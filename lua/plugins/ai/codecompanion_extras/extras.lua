local M = {}

local function deep_merge(...)
  return vim.tbl_deep_extend("force", ...)
end

-- Helper to create no-approval tool configuration
function M.no_approval()
  local tool_config = {
      opts = {
        require_approval_before = false,
        require_cmd_approval = false,
      },
    }
  return tool_config
end

function M.get_prompt_library()
  local pr = require("plugins.ai.codecompanion_extras.pr")
  local jira = require("plugins.ai.codecompanion_extras.jira")
  local mermaid = require("plugins.ai.codecompanion_extras.mermaid")

  return deep_merge(
    {},
    pr.get_prompt_library and pr.get_prompt_library() or {},
    jira.get_prompt_library and jira.get_prompt_library() or {},
    mermaid.get_prompt_library and mermaid.get_prompt_library() or {}
  )
end

function M.get_tools()
  local jira = require("plugins.ai.codecompanion_extras.jira")
  return jira.get_tools and jira.get_tools() or {}
end

function M.extend_opts(opts)
  local extras = {
    prompt_library = M.get_prompt_library(),
    interactions = {
      chat = {
        tools = M.get_tools(),
      },
    },
  }

  return deep_merge({}, opts or {}, extras)
end

return M
