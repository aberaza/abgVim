-- CodeCompanion Extras: Mermaid Diagram Generation
-- Custom prompt for generating accurate Mermaid flow diagrams
--
-- Specializes in: API call flows from controller to repository and back
-- Output: Accurate, working Mermaid sequence diagrams
--
-- Date: 2026-02-16

local M = {}

function M.get_prompt_library()
  return {
    ["Generate Mermaid Diagram"] = {
      strategy = "chat",
      description = "Generate accurate Mermaid sequence diagrams for API flows",
      opts = {
        index = 15,
        is_slash_cmd = true,
        slash_cmd = "mermaid",
        auto_submit = false,
        contains_code = true,
      },
      prompts = {
        {
          role = "system",
          content = [[You are an expert at creating Mermaid sequence diagrams for API flows.

Your task is to generate accurate, working Mermaid diagrams that trace the complete flow of an API call from the entry point (controller/route) through all layers (service, repository, database) and back.

**Key Requirements:**
1. Use proper Mermaid sequence diagram syntax
2. Show ALL participants (Controller, Service, Repository, Database, etc.)
3. Include request/response flows with clear labels
4. Show error handling paths if relevant
5. Use appropriate arrow types:
   - `->` for synchronous calls
   - `->>` for async calls (promises/await)
   - `-->>` for returns
   - `--x` for error returns
6. Add notes for important details
7. Use activation boxes (+ and -) to show when functions are active
8. Group related operations with `rect` blocks when needed

**Diagram Structure:**
```mermaid
sequenceDiagram
    participant Client
    participant Controller
    participant Service
    participant Repository
    participant Database
    
    Client->>+Controller: HTTP Request (method + data)
    Controller->>+Service: method(params)
    Service->>+Repository: query(filters)
    Repository->>+Database: SQL/Query
    Database-->>-Repository: Raw Data
    Repository-->>-Service: Mapped Entities
    Service-->>-Controller: Business Result
    Controller-->>-Client: HTTP Response
```

**Best Practices:**
- Start with participant declarations
- Use clear, descriptive labels for each interaction
- Show data transformations between layers
- Include HTTP status codes in responses
- Add error scenarios when relevant
- Keep it readable - don't overcomplicate

Always output the diagram in a proper markdown code block with the mermaid language identifier.]],
        },
        {
          role = "user",
          content = function(context)
            local input = context.args or ""
            
            if input == "" then
              return [[Please provide context for the Mermaid diagram:

**Option 1:** Describe the API flow
Example: "Show the flow for creating a new user: POST /api/users endpoint, UserController → UserService → UserRepository → Database"

**Option 2:** Select code and use visual mode to pass it to this prompt
I'll analyze the code and generate the corresponding diagram.

What would you like me to diagram?]]
            end
            
            return string.format([[Generate a Mermaid sequence diagram for the following API flow:

%s

Please:
1. Analyze the flow and identify all layers/components involved
2. Trace the request path from entry to database
3. Trace the response path back to the caller
4. Include data transformations at each layer
5. Show error handling if present
6. Output a complete, working Mermaid diagram

If code is provided, analyze it to extract the actual flow. If it's a description, create the diagram based on typical architectural patterns for that scenario.]], input)
          end,
        },
      },
    },
  }
end

return M
