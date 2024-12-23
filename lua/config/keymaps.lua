vim.g.mapleader = " "
vim.g.maplocalleader = ","

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

-- Some basic keybindings to match behavior or other editors
vim.api.nvim_set_keymap('n', '<C-s>', ':w<CR>', { noremap = true, silent = true, desc = 'Save file' })
vim.api.nvim_set_keymap('i', '<C-s>', '<Esc>:w<CR>a', { noremap = true, silent = true, desc = 'Save file' })


