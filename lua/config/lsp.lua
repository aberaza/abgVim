local ok, utils = pcall(require, 'config.utils')
if not ok then
  vim.notify('Failed to load config.utils for LSP setup', vim.log.levels.ERROR)
  return
end
local setup_keymaps = utils.setup_keymaps
local diagnostic_icons = utils.diagnostics

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    local opts = { buffer = ev.buf, silent = true }
    setup_keymaps(opts)
  end,
})

local severity = vim.diagnostic.severity
vim.diagnostic.config({
  signs = {
    text = {
      [severity.ERROR] = diagnostic_icons[severity.ERROR],
      [severity.WARN]  = diagnostic_icons[severity.WARN],
      [severity.HINT]  = diagnostic_icons[severity.HINT],
      [severity.INFO]  = diagnostic_icons[severity.INFO],
    },
  },
})

