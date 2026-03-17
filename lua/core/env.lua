-- Local script to load .env file into vim.env
-- Usage: require('core.env').load('.env')
-- Reads key-value pairs from the specified .env file and sets them in vim.env
-- Ignores lines starting with # (comments) and empty lines
-- Supports values enclosed in single or double quotes
-- Example .env
--   API_KEY="your_api_key_here"
local M = {}

local function trim(s)
  return (s:gsub("^%s*(.-)%s*$", "%1"))
end

function M.load(path)
  local f = io.open(path, "r")
  if not f then return end
  for line in f:lines() do
    line = trim(line)
    if line ~= "" and not line:match("^%s*#") then
      local k, v = line:match("^([%w_%-]+)%s*=%s*(.*)$")
      if k and v then
        -- remove surrounding quotes if present
        v = v:gsub('^"(.*)"$', "%1"):gsub("^'(.*)'$", "%1")
        v = trim(v)
        vim.env[k] = v
      end
    end
  end
  f:close()
end

return M
