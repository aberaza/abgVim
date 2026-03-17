local ok, utils = pcall(require, 'config.utils')
if not ok then
  vim.notify('Failed to load config.utils for LSP setup', vim.log.levels.ERROR)
  return
end
local setup_keymaps = utils.setup_keymaps
local diagnostic_icons = utils.diagnostics

-- Activate virtual text at "full" mode on startup (icon + message, source shown when multiple LSPs)
utils.set_virtual_text_mode('full')

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    local opts = { buffer = ev.buf, silent = true }
    setup_keymaps(opts)
  end,
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover,
  { border = "rounded" }
)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  { border = "rounded" }
)

local severity = vim.diagnostic.severity
-- Define diagnostic signs explicitly for broader compatibility across Neovim versions.
for name, icon in pairs({
  Error = diagnostic_icons[severity.ERROR],
  Warn = diagnostic_icons[severity.WARN],
  Hint = diagnostic_icons[severity.HINT],
  Info = diagnostic_icons[severity.INFO],
}) do
  vim.fn.sign_define("DiagnosticSign" .. name, { text = icon, texthl = "DiagnosticSign" .. name })
end
vim.diagnostic.config({
  signs = {
    text = {
      [severity.ERROR] = diagnostic_icons[severity.ERROR],
      [severity.WARN]  = diagnostic_icons[severity.WARN],
      [severity.HINT]  = diagnostic_icons[severity.HINT],
      [severity.INFO]  = diagnostic_icons[severity.INFO],
    },
  },
  float = {
    border = "rounded",
    source = "if_many",
  },
})
