local M = {}

function M.get_prompt_library()
  return {
    ["PR Agentic Loop"] = {
      strategy = "chat",
      description = "Analyze PR, propose implementation, test/review loop, final validation",
      opts = {
        index = 10,
        is_default = false,
        is_slash_cmd = true,
        short_name = "pr_loop",
        auto_submit = false,
        stop_context_insertion = false,
        user_prompt = true,
      },
      prompts = {
        {
          role = "system",
          content = [[
You are an autonomous software engineering workflow coordinator.

Follow this exact loop:
1) Analyze PR intent and constraints
2) Propose minimal implementation plan
3) Implement changes
4) Run tests (or provide exact test command + expected output format if execution is unavailable)
5) Review implementation against PR intent
6) Repeat until all checks pass or max iterations reached
7) Final validation against original PR

Rules:
- Keep changes minimal and safe.
- Prefer deterministic outputs.
- Return structured JSON for each phase.
- If information is missing, ask concise targeted questions.
- Max iterations: 5.
          ]],
        },
        {
          role = "user",
          content = [[
Execute the workflow for this PR/task:

{{input}}

Use this JSON schema in each iteration:
{
  "iteration": number,
  "analysis": {
    "goal": "string",
    "non_goals": ["string"],
    "acceptance_checks": ["string"]
  },
  "implementation_plan": {
    "files_to_change": ["string"],
    "steps": ["string"],
    "risks": ["string"]
  },
  "implementation_summary": {
    "changes": ["string"],
    "notes": ["string"]
  },
  "test_results": {
    "status": "pass|fail|not_run",
    "command": "string",
    "failing": ["string"],
    "summary": "string"
  },
  "review": {
    "blocking_issues": ["string"],
    "non_blocking_issues": ["string"],
    "meets_goal": true
  },
  "decision": {
    "continue": true,
    "reason": "string",
    "next_actions": ["string"]
  }
}

When done, output:
{
  "final_status": "accepted|needs_followup",
  "acceptance_coverage": ["string"],
  "remaining_risks": ["string"],
  "final_summary": "string"
}
          ]],
        },
      },
    },

    ["PR Review Only"] = {
      strategy = "chat",
      description = "Structured PR review without implementing changes",
      opts = {
        index = 11,
        is_default = false,
        is_slash_cmd = true,
        short_name = "pr_review",
        auto_submit = false,
        stop_context_insertion = false,
        user_prompt = true,
      },
      prompts = {
        {
          role = "system",
          content = [[
You are a strict PR reviewer.
Do not implement code.
Review for correctness, regressions, tests, edge cases, and maintainability.
Return concise structured JSON only.
          ]],
        },
        {
          role = "user",
          content = [[
Review this PR/task:

{{input}}

Return:
{
  "summary": "string",
  "blocking_issues": [
    { "title": "string", "why": "string", "suggestion": "string" }
  ],
  "non_blocking_issues": [
    { "title": "string", "why": "string", "suggestion": "string" }
  ],
  "test_gaps": ["string"],
  "risk_assessment": "low|medium|high",
  "approval": "approve|request_changes"
}
          ]],
        },
      },
    },
  }
end

return M
