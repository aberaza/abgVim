local H = {}

local severity = vim.diagnostic.severity

H.diagnostics = {
    [severity.ERROR]  = " ", -- ✘
    [severity.WARN]   = " ",
    [severity.HINT]   = " ", -- 󰠠 ⚑,
    [severity.INFO]   = " ", -- »
  }

H.dap = {
    Stopped             = " ",
    Breakpoint          = " ",
    BreakpointCondition = " ",
    BreakpointRejected  = " ",
    LogPoint            = " ",
    Rejected            = " ", 
  }

-- local virtual_text_mode = "full" -- full | minimal | off
local severity_to_name = {
  [severity.ERROR] = "Error",
  [severity.WARN] = "Warn",
  [severity.HINT] = "Hint",
  [severity.INFO] = "Info",
}

-- local function virtual_text_prefix(diagnostic)
--   local icon = "● "
--   local name = severity_to_name[diagnostic.severity] or "Info"
--   return { 
--     { icon, "DiagnosticVirtualText" .. name },
--     { (diagnostic.message or ""):gsub("\n.*", ""), "DiagnosticVirtualText" .. name },
--   }
-- end
--
--
-- local function virtual_text_format(diagnostic)
--   if virtual_text_mode == "minimal" then
--     return ""
--   end
--   return (diagnostic.message or ""):gsub("\n.*", "")
-- end
--
-- H.set_virtual_text_mode = function(mode)
--   local allowed = { full = true, minimal = true, off = true }
--   if not allowed[mode] then
--     return
--   end
--
--   virtual_text_mode = mode
--
--   if mode == "off" then
--     vim.diagnostic.config({ virtual_text = false })
--     return
--   end
--
--   vim.diagnostic.config({
--     virtual_text = {
--       spacing = 2,
--       prefix = virtual_text_prefix,
--       virtual_text = virtual_text_prefix
--       format = virtual_text_format,
--       source = mode == "full" and "if_many" or false,
--     },
--   })
-- end
--
-- H.toggle_virtual_text = function()
--   if virtual_text_mode == "off" then
--     H.set_virtual_text_mode("full")
--   else
--     H.set_virtual_text_mode("off")
--   end
--   vim.notify("Virtual text: " .. virtual_text_mode, vim.log.levels.INFO)
-- end
--
-- H.cycle_virtual_text = function()
--   local next_mode = {
--     full = "minimal",
--     minimal = "off",
--     off = "full",
--   }
--   H.set_virtual_text_mode(next_mode[virtual_text_mode] or "full")
--   vim.notify("Virtual text: " .. virtual_text_mode, vim.log.levels.INFO)
-- end
--

H.setup_keymaps = function(p_buffer)
  local buffer = p_buffer and p_buffer.buffer or 0
  local keymap = vim.keymap
  local key_opts = function (desc)
    return {buffer = buffer, desc = desc, nowait = true, silent = true}
  end

  -- Navigation (g prefix)
  keymap.set('n', 'gD', vim.lsp.buf.declaration, key_opts('Goto Declaration'))
  keymap.set('n', 'gd', vim.lsp.buf.definition, key_opts('Goto definition'))
  keymap.set('n', 'gy', vim.lsp.buf.type_definition, key_opts('Goto type definition'))
  keymap.set('n', 'gi', vim.lsp.buf.implementation, key_opts('Goto implementation'))
  -- keymap.set('n', 'gr', vim.lsp.buf.references, key_opts('Goto references'))
  keymap.set('n', 'gs', vim.lsp.buf.signature_help, key_opts('Signature Help'))

  keymap.set('n', 'gO','<cmd>FzfLua lsp_document_symbols<cr>', key_opts('Document Symbols'))
  keymap.set('n', 'gW','<cmd>FzfLua lsp_workspace_symbols<cr>', key_opts('Workspace Symbols'))

  -- Hover
  keymap.set('n', 'K', vim.lsp.buf.hover, key_opts('Hover Documentation'))
  keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, key_opts('Signature Help'))

  -- Code Actions (leader c prefix)
  keymap.set({'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action, key_opts('Code Action'))
  keymap.set('n', '<leader>cA', vim.lsp.buf.source_action or function()
    vim.lsp.buf.code_action({ context = { only = { 'source' } } })
  end, key_opts('Source Action'))
  keymap.set('n', '<leader>cr', vim.lsp.buf.rename, key_opts('Rename Symbol'))
  keymap.set('n', '<leader>cf', function() vim.lsp.buf.format({ async = true }) end, key_opts('Format Buffer'))
  keymap.set('x', '<leader>cF', vim.lsp.buf.format, key_opts('Format Selection'))

  -- Import management (if supported by LSP)
  keymap.set('n', '<leader>ci', function()
    -- Try to import all missing dependencies
    local params = {
      title = "Import all missing dependencies",
      context = { only = { "source.addMissingImports" } }
    }
    vim.lsp.buf.code_action(params)
  end, key_opts('Import All Missing'))

  keymap.set('n', '<leader>co', function()
    -- Try to organize imports
    local params = {
      title = "Organize imports",
      context = { only = { "source.organizeImports" } }
    }
    vim.lsp.buf.code_action(params)
  end, key_opts('Organize Imports'))

  -- Diagnostics (leader d prefix)
  keymap.set('n', '<leader>dd', vim.diagnostic.open_float, key_opts('Line Diagnostics'))
  keymap.set('n', 'gl', vim.diagnostic.open_float, key_opts('Line Diagnostics'))
  keymap.set('n', '[d', function() vim.diagnostic.jump({ count = -1 }) end, key_opts('Previous Diagnostic'))
  keymap.set('n', ']d', function() vim.diagnostic.jump({ count = 1 }) end, key_opts('Next Diagnostic'))
  keymap.set('n', '[e', function() vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR }) end, key_opts('Previous Error'))
  keymap.set('n', ']e', function() vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR }) end, key_opts('Next Error'))

  -- LSP Management (leader l prefix)
  keymap.set('n', '<leader>li', vim.lsp.buf.incoming_calls, key_opts('Incoming Calls'))
  keymap.set('n', '<leader>lr', function()
    for _, client in pairs(vim.lsp.get_clients({ bufnr = buffer })) do
      client.stop()
    end
  end, key_opts('Stop LSP'))
  keymap.set('n', '<leader>ll', function() vim.cmd('LspLog') end, key_opts('LSP Log'))

  -- UI/Toggles (leader u prefix)
  keymap.set('n', '<leader>uh', function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
  end, key_opts('Toggle Inlay Hints'))
  -- keymap.set('n', '<leader>uv', H.toggle_virtual_text, key_opts('Toggle Diagnostic Virtual Text'))
  -- keymap.set('n', '<leader>uV', H.cycle_virtual_text, key_opts('Cycle Diagnostic Virtual Text'))

  keymap.set('n', '<leader>us', function()
    vim.b.semantic_tokens_enabled = not vim.b.semantic_tokens_enabled
    vim.cmd('syntax sync fromstart')
  end, key_opts('Toggle Semantic Tokens'))
end


return H
