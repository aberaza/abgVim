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


H.setup_keymaps = function(p_buffer)
  local buffer = p_buffer and p_buffer.buffer or 0
  local keymap = vim.keymap
  local key_opts = function (desc)
    return {buffer = buffer, desc = desc, nowait = true, silent = true}
  end

  -- Navigation (g prefix)
  keymap.set('n', 'gD', vim.lsp.buf.declaration, key_opts('Goto Declaration'))
  keymap.set('n', 'gd', vim.lsp.buf.definition, key_opts('Goto definition'))
  keymap.set('n', 'gI', vim.lsp.buf.type_definition, key_opts('Goto type definition'))
  keymap.set('n', 'gi', vim.lsp.buf.implementation, key_opts('Goto implementation'))
  keymap.set('n', 'gr', vim.lsp.buf.references, key_opts('Goto references'))
  keymap.set('n', 'gs', vim.lsp.buf.signature_help, key_opts('Signature Help'))

  -- Document/Workspace symbols (if telescope is available)
  local ok, telescope = pcall(require, 'telescope.builtin')
  if ok then
    keymap.set('n', 'gO', telescope.lsp_document_symbols, key_opts('Document Symbols'))
    keymap.set('n', 'gW', telescope.lsp_workspace_symbols, key_opts('Workspace Symbols'))
  end

  -- Hover
  keymap.set('n', 'K', vim.lsp.buf.hover, key_opts('Hover Documentation'))
  keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, key_opts('Signature Help'))

  -- Code Actions (leader c prefix)
  keymap.set({'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action, key_opts('Code Action'))
  keymap.set('n', '<leader>cA', vim.lsp.buf.source_action, key_opts('Source Action'))
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
  keymap.set('n', '[d', vim.diagnostic.goto_prev, key_opts('Previous Diagnostic'))
  keymap.set('n', ']d', vim.diagnostic.goto_next, key_opts('Next Diagnostic'))
  keymap.set('n', '[e', function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end, key_opts('Previous Error'))
  keymap.set('n', ']e', function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end, key_opts('Next Error'))

  -- LSP Management (leader l prefix)
  keymap.set('n', '<leader>li', vim.lsp.buf.incoming_calls, key_opts('Incoming Calls'))
  keymap.set('n', '<leader>lr', function() vim.lsp.stop_client(vim.lsp.get_active_clients()) end, key_opts('Stop LSP'))
  keymap.set('n', '<leader>ll', function() vim.cmd('LspLog') end, key_opts('LSP Log'))

  -- UI/Toggles (leader u prefix)
  keymap.set('n', '<leader>uh', function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
  end, key_opts('Toggle Inlay Hints'))

  keymap.set('n', '<leader>us', function()
    vim.b.semantic_tokens_enabled = not vim.b.semantic_tokens_enabled
    vim.cmd('syntax sync fromstart')
  end, key_opts('Toggle Semantic Tokens'))
end


return H
