-- CodeCompanion Extras: JIRA Integration
-- Custom slash commands, workflows, and tools for JIRA ticket automation
--
-- This module provides:
-- - /jira command: Analyze JIRA tickets with complexity estimation  
-- - /jira_start workflow: Full automation (analyze → branch → implement → test)
-- - @jira_analyze tool: Agentic ticket analysis
-- - @jira_create_branch tool: Agentic git branch creation
--
-- Architecture: Uses chat history as state (no explicit state management)
-- Dependencies: hexagon-apps JIRA tools (via symlinks in hexagon-front)
--
-- Author: Extracted from VimPlug config
-- Date: 2026-01-28

local M = {}

-- Return JIRA-related prompt library entries
-- Includes: /jira command and /jira_start workflow (9 phases)
function M.get_prompt_library()
  return {
    ["JIRA Analyze Ticket"] = {
      strategy = "chat",
      description = "Analyze a JIRA ticket with complexity estimation and implementation recommendations",
      opts = {
        index = 10,
        is_slash_cmd = true,
        slash_cmd = "jira",
        auto_submit = false,
        contains_code = false,
      },
      prompts = {
        {
          role = "user",
          content = function(context)
            local ticket_id = context.args or ""
            
            if ticket_id == "" then
              return "Error: Please provide a JIRA ticket ID. Usage: /jira PIM-1234"
            end
            
            local cmd = string.format(
              "cd /Users/aritz.beraza/Workspace/hexagon-apps && npx tsx .opencode/tools/jira-analyzer.ts %s 2>&1",
              vim.fn.shellescape(ticket_id:upper())
            )
            
            local output = vim.fn.system(cmd)
            local exit_code = vim.v.shell_error
            
            if exit_code ~= 0 then
              return string.format(
                "Error fetching JIRA ticket %s:\n\n```\n%s\n```\n\nPlease check:\n- VPN connection\n- JIRA credentials in .env\n- Ticket ID is valid",
                ticket_id,
                output
              )
            end
            
            local ok, analysis = pcall(vim.json.decode, output)
            if not ok then
              return string.format("Error parsing JIRA analysis:\n\n```\n%s\n```", output)
            end
            
            return string.format([[I've fetched and analyzed JIRA ticket %s. Here's the analysis:

**Ticket Information:**
- ID: %s
- Type: %s
- Priority: %s
- Status: %s
- Summary: %s

**Complexity Analysis:**
- Complexity: %s
- Estimated Story Points: %s
- Branch Type: %s
- Suggested Branch Name: %s

**Description:**
%s

**Affected Areas:**
%s

**Risk Factors:**
%s

**Implementation Strategy:**
%s

%s

Please provide recommendations based on this analysis.]],
              ticket_id,
              analysis.ticket.id,
              analysis.ticket.type,
              analysis.ticket.priority,
              analysis.ticket.status,
              analysis.ticket.summary,
              analysis.complexity,
              analysis.storyPoints,
              analysis.branchType,
              analysis.branchName,
              analysis.ticket.description,
              table.concat(analysis.affectedAreas or {}, ", "),
              table.concat(analysis.riskFactors or {}, "\n- "),
              analysis.implementationStrategy,
              analysis.shouldRecommendSplit and "\n⚠️ **WARNING:** This ticket is very complex and should be split into smaller stories." or ""
            )
          end,
        },
      },
    },
    
    ["JIRA Auto-Implementation"] = {
      strategy = "workflow",
      description = "Full automation: analyze ticket → branch → implement → test",
      opts = {
        index = 11,
        is_slash_cmd = true,
        slash_cmd = "jira_start",
        auto_submit = true,
      },
      prompts = {
        -- PHASE 1: Ticket Analysis
        {
          {
            role = "user",
            content = function(context)
              local ticket_id = context.args or ""
              if ticket_id == "" then
                return "Error: Please provide a JIRA ticket ID. Usage: /jira_start PIM-1234"
              end
              
              return string.format([[Analyze JIRA ticket %s using the @jira_analyze tool.

After you receive the analysis, determine the implementation approach based on complexity:
- If storyPoints >= 8: This is VERY COMPLEX - we'll need to discuss options
- If storyPoints 2-5: This is MEDIUM - we'll show a plan for approval  
- If storyPoints <= 1: This is SIMPLE - we can auto-implement

Invoke the tool now and then assess the complexity.]], ticket_id:upper())
            end,
            opts = { auto_submit = true },
          },
        },
        
        -- PHASE 2: Decision Point
        {
          {
            role = "user",
            content = [[Based on the ticket analysis you just received, determine the next steps:

**If storyPoints >= 8 (Very Complex):**
Display this warning and ASK me what to do (do NOT auto-submit):

```
⚠️ WARNING: Very Complex Ticket ([X] points)

Risk Factors:
[List risk factors from analysis]

Recommendation: Split into smaller stories (2-3 points each)

This ticket is too complex for automated implementation.

Options:
1. STOP - Go back and split the ticket in JIRA
2. PLAN - Show detailed implementation plan only (no code changes)
3. PROCEED - Continue anyway (not recommended)

What would you like to do? [Type: stop, plan, or proceed]
```

**If storyPoints 2-5 (Medium Complexity):**
Display a detailed implementation plan (we'll define format in Phase 4) and ask:

```
📦 Implementation Plan Required

This is a [complexity] complexity ticket ([X] points).
Let me create a detailed implementation plan for your review.

Affected Areas: [list from analysis]

⚠️ Risk Factors:
[list if any]

Branch: [branchName from analysis]

[Show detailed plan - see Phase 4 format]

Ready to proceed with this implementation? [Type: yes or no]
```

**If storyPoints <= 1 (Simple):**
Display and continue automatically:

```
✅ Auto-implementing (Simple: [X] point ticket)

Branch: [branchName from analysis]
Affected Areas: [list from analysis]

Proceeding with automatic implementation...
```

DO NOT auto-submit this response if you're asking for user input (complex or medium tickets).
DO auto-submit if it's a simple ticket (<=1 point).

Assess the complexity now and respond accordingly.]],
            opts = { auto_submit = true },
          },
        },
        
        -- PHASE 3: Branch Creation
        {
          {
            role = "user",
            content = [[Now let's create the feature branch.

Look back at the ticket analysis for the branch name (it was in the branchName field).

Use the @jira_create_branch tool with that branch name.

This will:
1. Check for uncommitted changes (will error if any exist)
2. Update master from remote
3. Create the new feature branch
4. Switch to that branch

After the branch is created successfully, we'll proceed with implementation planning.]],
            opts = { auto_submit = true },
            condition = function(chat)
              -- Check if user approved or it's auto-proceeding
              local messages = chat:get_messages()
              if not messages or #messages == 0 then return false end
              
              -- Look at recent messages for approval signals
              for i = #messages, math.max(1, #messages - 3), -1 do
                local msg = messages[i]
                if msg.role == "user" then
                  local content = (msg.content or ""):lower()
                  -- Proceed if user said yes/proceed, or if it was auto-implementing
                  if content:match("yes") or content:match("proceed") or content:match("auto%-implementing") then
                    return true
                  end
                  -- Stop if user said no/stop
                  if content:match("no") or content:match("stop") then
                    return false
                  end
                end
              end
              
              return false
            end,
          },
        },
        
        -- PHASE 4: Implementation Planning
        {
          {
            role = "user",
            content = [[Now create a detailed implementation plan by exploring the codebase.

Reference the ticket description and requirements from the earlier analysis.

Use these tools to gather context:
- @file_search: Find relevant files by pattern (e.g., "**/*Table*.tsx", "**/*Domain*.ts")
- @grep_search: Search for similar implementations or patterns
- @read_file: Examine existing code to understand patterns

For this React/TypeScript frontend project (hexagon-front), identify:

**Components to Modify/Create:**
- Which React components need changes
- New components to create
- Shared utilities or custom hooks needed

**State Management:**
- Redux slices/actions to modify (if needed)
- React Query hooks for data fetching (prefer this over Redux for server state)
- Local component state changes

**Types & Interfaces:**
- TypeScript types to add/modify
- Props interfaces to update
- API response types

**Styling:**
- Styled components to create/modify (use @mui/system styled())
- New .style.ts files needed

**Test Files:**
- Component tests to update (__tests__/*.test.tsx)
- New test files needed

Display the plan in this format:

```
📁 Files to Modify/Create:

Components:
  - src/components/[Area]/[Component].tsx - [reason]
  - src/components/[Area]/[Component].style.ts - [styling]

Hooks:
  - src/shared/hooks/use[Hook].ts - [purpose]

Types:
  - src/shared/types/[type].ts - [what types]

State (if needed):
  - Redux: src/store/[slice].ts
  - React Query: src/shared/hooks/queries/use[Query].ts

Tests:
  - src/components/[Area]/__tests__/[Component].test.tsx

🧪 Test Strategy:
- Test [scenario 1]
- Test [scenario 2]
- Test edge cases: [list]
- Mock dependencies: [what to mock]

Implementation Steps:
1. [Step 1 - usually types first]
2. [Step 2 - shared utilities/hooks]
3. [Step 3 - component changes]
4. [Step 4 - styling]
5. [Step 5 - tests]
```

After displaying the plan, proceed directly to implementation (auto-submit).]],
            opts = { auto_submit = true },
          },
        },
        
        -- PHASE 5: Code Implementation
        {
          {
            role = "user",
            content = [[Now implement the changes based on your plan and the ticket requirements.

**Implementation Guidelines:**

1. **Read files first** - Use @read_file to understand existing patterns
2. **Follow project conventions** (from AGENTS.md):
   - Single quotes, no semicolons
   - 2-space indentation, 150 char line width
   - Functional components only, use hooks
   - Component files: PascalCase (e.g., MyComponent.tsx)
   - Styled components in separate .style.ts files
   - Import order: React → external libs → @/* aliases → relative paths
   - Use `import type` for type-only imports
   - Boolean variables: prefix with `is`/`has`
   - Prefer @tanstack/react-query for server state

3. **Use tools properly**:
   - @read_file: Read existing files to understand patterns
   - @insert_edit_into_file: Modify existing files
   - Create new files only when necessary

4. **Add clear comments**: Explain WHY, not just WHAT

5. **Work incrementally**:
   - Types/interfaces first
   - Shared hooks/utilities next
   - Component modifications
   - Styling changes
   - New components last

6. **Track progress**: Mention each file as you modify it

Reference the ticket requirements and your implementation plan from earlier in this conversation.

Work through each file methodically. After all implementation is done, explicitly say "Implementation complete" and move to tests.]],
            opts = { auto_submit = true },
          },
        },
        
        -- PHASE 6: Test Implementation
        {
          {
            role = "user",
            content = [[Now create or update unit tests for the implementation.

**Test Strategy:**

1. **Find existing test patterns**:
   - Use @file_search: "**/__tests__/*.test.tsx"
   - Read similar test files with @read_file to understand patterns

2. **Testing framework**: Jest + React Testing Library + @testing-library/jest-dom

3. **Test structure** (follow AAA pattern):
```typescript
import { render, screen, waitFor } from '@testing-library/react'
import userEvent from '@testing-library/user-event'
import { MyComponent } from '../MyComponent'

describe('MyComponent', () => {
  it('should [expected behavior] when [condition]', async () => {
    // Arrange - setup
    const mockFn = jest.fn()
    
    // Act - user action or render
    render(<MyComponent onAction={mockFn} />)
    
    // Assert - verify behavior
    expect(screen.getByRole('button')).toBeInTheDocument()
  })
})
```

4. **Test Coverage**:
   - Happy path scenarios
   - Edge cases (empty data, null, undefined, boundary values)
   - Error handling (API failures, validation errors)
   - User interactions (clicks, form inputs, navigation)
   - Async operations (use waitFor, findBy queries)

5. **Common patterns**:
   - Mock modules: `jest.mock('module-path')`
   - Mock API calls: Mock axios or use MSW
   - Mock hooks: `jest.spyOn(hooks, 'useMyHook').mockReturnValue(...)`
   - User interactions: `await userEvent.click(element)`
   - Async waits: `await waitFor(() => expect(...).toBeInTheDocument())`
   - Queries: Prefer `getByRole`, `getByLabelText`, `getByText` over testIds

6. **Test file naming**: `[Component].test.tsx` in `__tests__` folder

Reference the implementation files you just modified to ensure tests cover the new/changed behavior.

After creating/updating tests, explicitly say "Tests complete" and proceed to running them.]],
            opts = { auto_submit = true },
          },
        },
        
        -- PHASE 7: Lint & Test Execution
        {
          {
            role = "user",
            content = [[Now let's validate the implementation.

**Step 1: Run Lint Fix**

First, auto-fix any style issues:

Use @cmd_runner to run:
```
npm run lint:fix
```

Wait for it to complete.

**Step 2: Run Tests**

Based on the files you modified, identify test patterns and run relevant tests.

For example:
- If you modified `src/components/Table/DataTable.tsx`
- Test file would be `src/components/Table/__tests__/DataTable.test.tsx`
- Run: `npm test -- --testPathPattern="DataTable"`

Or if multiple related files:
- Run: `npm test -- --testPathPattern="Table"`

Use @cmd_runner to execute the test command.

**Important**: 
- Run BOTH commands (lint then test)
- Use appropriate test pattern based on what you modified
- Wait for test results before proceeding

After tests run, check the output:
- If all pass: Great! We'll move to the summary
- If any fail: Don't worry, the next phase will handle retries

Execute both commands now.]],
            opts = { auto_submit = true },
          },
        },
        
        -- PHASE 8: Retry on Test Failure
        {
          {
            role = "user",
            content = function(context)
              return [[The tests failed. Let's analyze and fix the issues.

**Failure Analysis Process:**

1. **Read the test output carefully** - identify the exact error
2. **Categorize the failure**:
   - Implementation bug (logic error in your code)
   - Test code issue (test expectations wrong)
   - Missing mock/dependency (forgot to mock something)
   - Type error (TypeScript compilation issue)
   - Import error (wrong path or missing export)

3. **Fix the appropriate files**:
   - Use @read_file to re-examine the failing code
   - Use @insert_edit_into_file to apply fixes
   - Fix implementation code OR test code as needed

4. **Re-run tests**:
   - Use @cmd_runner with the same test pattern
   - Example: `npm test -- --testPathPattern="[YourPattern]"`

**Retry Limits:**
- This is attempt [X] of 3
- If tests still fail after 3 attempts, we'll stop and report for manual intervention
- Each attempt should try a different approach if the previous fix didn't work

**Tips:**
- Read error messages carefully - they usually tell you exactly what's wrong
- Check for typos in imports, function names, props
- Ensure mocks match the actual implementation signature
- Verify test queries match actual rendered elements

Analyze the failure, fix the issue, and retry now.]]
            end,
            opts = { auto_submit = true },
            condition = function(chat)
              -- Only run if cmd_runner just executed and it was a test command
              if not chat.tools or not chat.tools.tool then return false end
              if chat.tools.tool.name ~= "cmd_runner" then return false end
              
              -- Check if it was a test command (check recent messages for test pattern)
              local messages = chat:get_messages()
              for i = #messages, math.max(1, #messages - 3), -1 do
                local msg = messages[i]
                local content = msg.content or ""
                if content:match("npm test") or content:match("testPathPattern") then
                  return true
                end
              end
              
              return false
            end,
            repeat_until = function(chat)
              -- Stop repeating when tests pass (testing flag = true)
              if chat.tool_registry and chat.tool_registry.flags and chat.tool_registry.flags.testing == true then
                chat._jira_test_attempts = 0  -- Reset for future runs
                return true
              end
              
              -- Track attempt count
              chat._jira_test_attempts = (chat._jira_test_attempts or 0) + 1
              
              if chat._jira_test_attempts >= 3 then
                vim.notify("Max test retry attempts (3) reached. Moving to summary.", vim.log.levels.WARN)
                return true  -- Stop repeating
              end
              
              return false  -- Continue repeating
            end,
          },
        },
        
        -- PHASE 9: Summary & Next Steps
        {
          {
            role = "user",
            content = [[Provide a complete implementation summary.

Look back through our conversation to gather:
- Ticket ID and summary (from Phase 1 - the @jira_analyze output)
- Branch name (from Phase 3 - the @jira_create_branch output)
- All files you modified (from Phase 5 & 6 - your implementation and test work)
- Test results (from Phase 7/8 - the test execution output)

Display in this format:

```
✅ Implementation Complete!

📋 Ticket: [ID] - [summary]
🌿 Branch: [branch-name]
📁 Files Modified ([count]):
  - [file1.tsx]
  - [file2.ts]
  - [file3.test.tsx]
  ...

🧪 Tests: [X] passed / [Y] total
[If any failures after 3 attempts:]
⚠️ [N] tests need attention:
  - [TestName]: [brief error description]
  - [TestName]: [brief error description]

📝 Changes Summary:
[2-3 sentence summary of what was implemented based on the ticket requirements]

---

🎯 Next Steps:

1. Review changes:
   git diff master

2. Review modified files in your editor

3. [If all tests passed:]
   (Optional) Run full test suite:
   npm test
   
   [If tests failed after 3 attempts:]
   ⚠️ Fix failing tests manually:
   - Review test output above
   - Common issues: missing mocks, incorrect assertions, timing issues
   - Run: npm test -- --testPathPattern="[Pattern]"
   - Fix until all tests pass

4. Commit your changes:
   git add .
   git commit -m "[type](pim-[ticketNum]): [brief summary]"
   
   Example: git commit -m "feat(pim-5762): add domain link improvement"

5. Push to remote:
   git push -u origin [branch-name]

6. Create Pull Request:
   gh pr create --title "[Type]: [Summary]" --body "Closes [TICKET-ID]"
   
   Or create PR via your Git UI/GitHub website

---

💡 Tips:
- Carefully review all code changes before committing
- Ensure tests pass before creating the PR
- Write a clear commit message referencing the ticket
- Add the JIRA ticket ID in the PR description
- Request reviews from team members familiar with affected areas
```

Present this summary now (do NOT auto-submit - let me see the final summary).]],
            opts = { auto_submit = false },
            condition = function(chat)
              -- Run after testing completes (either passed or hit max retries)
              local testing_done = false
              
              -- Check if tests passed
              if chat.tool_registry and chat.tool_registry.flags then
                if chat.tool_registry.flags.testing == true then
                  testing_done = true
                end
              end
              
              -- Or check if we hit max retries
              if (chat._jira_test_attempts or 0) >= 3 then
                testing_done = true
              end
              
              -- Also check if cmd_runner executed at least once (lint or test ran)
              if not testing_done then
                local messages = chat:get_messages()
                for i = #messages, math.max(1, #messages - 5), -1 do
                  local msg = messages[i]
                  local content = msg.content or ""
                  if content:match("npm test") or content:match("npm run lint") then
                    testing_done = true
                    break
                  end
                end
              end
              
              return testing_done
            end,
          },
        },
      },
    },
  }
end

-- Return JIRA-related tools
-- Includes: @jira_analyze and @jira_create_branch
function M.get_tools()
  return {
        jira_analyze = {
          description = "Analyze JIRA tickets for complexity and implementation planning",
          callback = {
            name = "jira_analyze",
            
            cmds = {
              function(self, args, input)
                local ticket_id = args.ticket_id
                
                if not ticket_id or ticket_id == "" then
                  return {
                    status = "error",
                    data = "ticket_id is required. Example: PIM-5762"
                  }
                end
                
                local cmd = string.format(
                  "cd /Users/aritz.beraza/Workspace/hexagon-apps && npx tsx .opencode/tools/jira-analyzer.ts %s 2>&1",
                  vim.fn.shellescape(ticket_id:upper())
                )
                
                local handle = io.popen(cmd)
                if not handle then
                  return {
                    status = "error",
                    data = "Failed to execute jira-analyzer command"
                  }
                end
                
                local output = handle:read("*a")
                local success = handle:close()
                
                if not success then
                  return {
                    status = "error",
                    data = string.format("JIRA API error:\n%s\n\nPlease check VPN and credentials.", output)
                  }
                end
                
                local ok, analysis = pcall(vim.json.decode, output)
                if not ok then
                  return {
                    status = "error",
                    data = string.format("Failed to parse JIRA analysis: %s", output)
                  }
                end
                
                local formatted = string.format([[JIRA Ticket Analysis: %s

Type: %s
Priority: %s
Summary: %s
Complexity: %s (%s story points)
Branch: %s

Description:
%s

Affected Areas: %s
Risk Factors: %s

Implementation Strategy: %s]],
                  analysis.ticket.id,
                  analysis.ticket.type,
                  analysis.ticket.priority,
                  analysis.ticket.summary,
                  analysis.complexity,
                  analysis.storyPoints,
                  analysis.branchName,
                  analysis.ticket.description,
                  table.concat(analysis.affectedAreas or {}, ", "),
                  table.concat(analysis.riskFactors or {}, "; "),
                  analysis.implementationStrategy
                )
                
                return {
                  status = "success",
                  data = formatted
                }
              end,
            },
            
            system_prompt = [[## JIRA Analyze Tool (@jira_analyze)

### CONTEXT
- You have access to a JIRA ticket analyzer running in the developer's environment
- It fetches tickets from the PIM project JIRA instance
- Provides complexity estimation, story points, and implementation recommendations

### WHEN TO USE
- User mentions implementing a JIRA ticket (e.g., "implement PIM-5762")
- User asks about ticket details or complexity
- Planning implementation work
- Need context about requirements

### RESPONSE FORMAT
- Always provide the full ticket context to the user
- Highlight complexity and risk factors
- Offer implementation recommendations based on the analysis]],
            
            schema = {
              type = "function",
              ["function"] = {
                name = "jira_analyze",
                description = "Fetch and analyze a JIRA ticket from the PIM project, providing complexity estimation, story points, affected areas, risk factors, and implementation strategy",
                parameters = {
                  type = "object",
                  properties = {
                    ticket_id = {
                      type = "string",
                      description = "The JIRA ticket ID to analyze (e.g., 'PIM-5762', 'PIM-1234')",
                      pattern = "^PIM-[0-9]+$",
                    },
                  },
                  required = { "ticket_id" },
                  additionalProperties = false,
                },
                strict = true,
              },
            },
            
            handlers = {
              setup = function(self, tools)
                vim.notify(string.format("Fetching JIRA ticket %s...", self.args.ticket_id), vim.log.levels.INFO)
              end,
              
              on_exit = function(self, tools)
                vim.notify("JIRA analysis complete", vim.log.levels.INFO)
              end,
            },
            
            output = {
              success = function(self, tools, cmd, stdout)
                local chat = tools.chat
                return chat:add_tool_output(
                  self,
                  stdout[1],
                  string.format("✅ Fetched and analyzed JIRA ticket %s", self.args.ticket_id)
                )
              end,
              
              error = function(self, tools, cmd, stderr)
                local chat = tools.chat
                return chat:add_tool_output(
                  self,
                  stderr[1],
                  string.format("❌ Failed to fetch JIRA ticket %s", self.args.ticket_id)
                )
              end,
            },
            
            opts = {
              require_approval_before = false,
            },
          },
        },
        
        jira_create_branch = {
          description = "Create a git feature branch for JIRA ticket implementation",
          callback = {
            name = "jira_create_branch",
            
            cmds = {
              function(self, args, input)
                local branch_name = args.branch_name
                
                if not branch_name or branch_name == "" then
                  return {
                    status = "error",
                    data = "branch_name is required"
                  }
                end
                
                local status_output = vim.fn.system("git status --porcelain")
                if status_output ~= "" then
                  return {
                    status = "error",
                    data = "Uncommitted changes detected. Please commit or stash before creating a branch."
                  }
                end
                
                vim.fn.system("git checkout master && git pull origin master")
                
                local branch_exists = vim.fn.system(string.format("git rev-parse --verify %s 2>/dev/null", vim.fn.shellescape(branch_name)))
                if branch_exists ~= "" then
                  return {
                    status = "error",
                    data = string.format("Branch '%s' already exists", branch_name)
                  }
                end
                
                local create_result = vim.fn.system(string.format("git checkout -b %s", vim.fn.shellescape(branch_name)))
                
                if vim.v.shell_error ~= 0 then
                  return {
                    status = "error",
                    data = string.format("Failed to create branch: %s", create_result)
                  }
                end
                
                return {
                  status = "success",
                  data = string.format("Created and switched to branch: %s", branch_name)
                }
              end,
            },
            
            system_prompt = [[## Git Branch Creation Tool (@jira_create_branch)

### CONTEXT
- Creates a new git feature branch from an up-to-date master branch
- Checks for uncommitted changes before branching
- Verifies branch doesn't already exist

### WHEN TO USE
- Starting implementation of a JIRA ticket
- User asks to create a branch for a ticket
- Part of automated ticket implementation workflow

### SAFETY
- Requires user approval (require_approval_before = true)
- Checks for uncommitted changes
- Updates master before branching]],
            
            schema = {
              type = "function",
              ["function"] = {
                name = "jira_create_branch",
                description = "Create a git feature branch from up-to-date master for implementing a JIRA ticket",
                parameters = {
                  type = "object",
                  properties = {
                    branch_name = {
                      type = "string",
                      description = "The branch name to create (e.g., 'feat/pim5762-improve-domain-link')",
                    },
                  },
                  required = { "branch_name" },
                  additionalProperties = false,
                },
                strict = true,
              },
            },
            
            handlers = {
              setup = function(self, tools)
                vim.notify(string.format("Creating branch: %s", self.args.branch_name), vim.log.levels.INFO)
              end,
            },
            
            output = {
              success = function(self, tools, cmd, stdout)
                local chat = tools.chat
                return chat:add_tool_output(self, stdout[1])
              end,
              
              error = function(self, tools, cmd, stderr)
                local chat = tools.chat
                return chat:add_tool_output(self, stderr[1])
              end,
              
              prompt = function(self, tools)
                return string.format("Create git branch '%s'?", self.args.branch_name)
              end,
              
              rejected = function(self, tools, cmd)
                tools.chat:add_tool_output(self, "Branch creation was rejected by user")
              end,
            },
            
            opts = {
              require_approval_before = true,
            },
          },
        },
  }
end

return M

