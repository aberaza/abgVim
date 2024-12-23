-- add ' ~/abgVim/lua to runtime path
vim.o.runtimepath = vim.o.runtimepath .. ',' .. vim.fn.expand('~/abgVim')
-- package.path = package.path .. ';' .. vim.fn.expand('~/abgVim/lua/?.lua')

require('config.options')
require('config.keymaps')
require('config.lazy')


