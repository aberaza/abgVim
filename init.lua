-- add ' ~/abgVim/lua to runtime path
vim.o.runtimepath = vim.o.runtimepath .. ',' .. vim.fn.expand('~/abgVim')
-- package.path = package.path .. ';' .. vim.fn.expand('~/abgVim/lua/?.lua')

-- Load environment variables from .env file
-- require('core.env').load(vim.fn.expand('~/.config/nvim/.env'))
require('core.env').load(vim.fn.stdpath('config') .. '/.env')

-- Set leader keys before any plugin or keymap loading
vim.g.mapleader = " "
vim.g.maplocalleader = ","

require('config.options')
require('config.keymaps')
require('config.lsp')
require('config.lazy')


