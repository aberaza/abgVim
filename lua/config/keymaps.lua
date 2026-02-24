-- Leader keys are set in init.lua before this file is loaded

-- Avoid tying mistakes
vim.cmd([[
  cnoreabbrev W! w!
  cnoreabbrev Q! q!
  cnoreabbrev Qall! qall!
  cnoreabbrev Wq wq
  cnoreabbrev Wa wa
  cnoreabbrev wQ wq
  cnoreabbrev WQ wq
  cnoreabbrev W w
  cnoreabbrev Q q
  cnoreabbrev Qall qall
]])

-- Some basic keybindings to match behavior of other editors
vim.keymap.set('n', '<C-s>', '<cmd>w<CR>', { noremap = true, silent = true, desc = 'Save file' })
vim.keymap.set('i', '<C-s>', '<Esc><cmd>w<CR>a', { noremap = true, silent = true, desc = 'Save file' })
vim.keymap.set('n', '<leader>w', '<cmd>w<CR>', { noremap = true, silent = true, desc = 'Save file' })
vim.keymap.set('v', '<leader>w', '<cmd>w<CR>', { noremap = true, silent = true, desc = 'Save file' })



local ctx = require("core.context_keys")
-- vim.keymap.set("n", "<leader>k", ctx.show({prefix_depth = 1}), { desc = "Show buffer contextual keymaps" })

