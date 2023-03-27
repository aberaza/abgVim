local status, fzf = pcall(require, 'fzf-lua')
if (not status) then return end

-- fzf.setup {'telescope'}
fzf.setup {
  file_ignore_patterns = {"%.py$", "%.git$", "node_modules", "packages", "build", "pub"},
  multiprocess=true,
  files = {
    prompt = "Files> ",
    git_icons = false,
-- improve a bit of speed
    file_icons = true,
-- but keep some icons
  },
  buffers = {
    git_icons = false,
  },
  lsp = {
    icons = {
      ['Error'] = { icon = "", color = 'red' },
      ['Warning'] = { icon = "", color = 'yellow' },
      ['Information'] = { icon = "", color = 'blue' },
      ['Hint'] = { icon = "", color = 'blue' },
    }
  },
  lsp_diagnostics_document = {
    icons = {
      ['Error'] = { icon = "", color = 'red' },
      ['Warning'] = { icon = "", color = 'yellow' },
      ['Information'] = { icon = "", color = 'blue' },
      ['Hint'] = { icon = "", color = 'blue' },
    }
  },
}
-- KEYMAPS
-- local signs = { Error = "", Warn = "", Hint = "", Info = "" }
-- -- local signs = { Error = "✘", Warn = "▲", Hint = "⚑", Info = "" }

vim.keymap.set('n', '<c-P>', "<cmd>lua require('fzf-lua').files()<CR>", { noremap = true, silent = true })
vim.keymap.set('n', '<leader>fb',  "<cmd>lua require('fzf-lua').buffers()<CR>", {   noremap = true, silent = true })
vim.keymap.set('n', '<leader>vt',  "<cmd>lua require('fzf-lua').colorschemes()<CR>", {   noremap = true, silent = true })
vim.keymap.set('n', '<leader>vh',  "<cmd>lua require('fzf-lua').help_tags()<CR>", {   noremap = true, silent = true })
vim.keymap.set('n', '<leader>vk',  "<cmd>lua require('fzf-lua').keymaps()<CR>", {   noremap = true, silent = true })

vim.keymap.set('n', '<leader>s', "<cmd>lua require('fzf-lua').grep_visual()<CR>", {   noremap = true, silent = true })
vim.keymap.set('n', '<leader>*', "<cmd>lua require('fzf-lua').grep_cword()<CR>", {   noremap = true, silent = true })
