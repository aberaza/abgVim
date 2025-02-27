local diagnostic_icons = require('config.utils').diagnostics
local setup_keymaps = require('config.utils').setup_keymaps


capabilities = vim.lsp.protocol.make_client_capabilities()

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
      [severity.ERROR] = " ",
      [severity.WARN] = " ",
      [severity.HINT] = "󰠠 ",
      [severity.INFO] = " ",
    },
  },
})

-- vim.diagnostic.config({
--   signs = {
--     text = diagnostic_icons,
--   },
-- })

