local M = {}

M.servers = { 'ts_ls', 'jsonls', 'html', 'vimls', 'csharp_ls' }

M.capabilities = vim.lsp.protocol.make_client_capabilities()


M.setup = function()
  local keymap = vim.keymap

  keymap.set('n', 'gD', vim.lsp.buf.declaration, desc('Goto Declaration'))
  keymap.set('n', 'gd', vim.lsp.buf.definition, desc('Goto definition'))
  keymap.set('n', 'go', vim.lsp.buf.type_definition, desc('Goto type definition'))
  keymap.set('n', 'gi', vim.lsp.buf.implementation, desc('Goto implementation'))
  keymap.set('n', 'gr', vim.lsp.buf.references, desc('Goto references'))

  keymap.set('n', 'gs', vim.lsp.buf.signature_help, desc('Signature Help'))
  keymap.set('n', 'K', vim.lsp.buf.hover, desc('Hover'))

  keymap.set('n', 'cr', vim.lsp.buf.rename, desc('Rename Symbol'))
  keymap.set('n', '<space>cf', function() vim.lsp.buf.format { async = true } end, desc('Format Buffer'))
end

return M
