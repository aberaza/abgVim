local status, miniclue = pcall(require, 'mini.clue')
if (not status) then return end
-- Provide help with keymappings, clashes with Which 
miniclue.setup({
  triggers = {
    -- Leader triggers
    { mode = 'n', keys = '<leader>' },
    { mode = 'x', keys = '<leader>' },
    -- Windows
    { mode = 'n', keys = '<C-w>' },
    -- Registers
    { mode = 'n', keys = '"' },
    { mode = 'x', keys = '"' },
    { mode = 'i', keys = '<C-r>' },
    { mode = 'c', keys = '<C-r>' },
    -- Built-in completion
    -- { mode = 'i', keys = '<C-x>' },
    -- Marks
    { mode = 'n', keys = "'" },
    { mode = 'n', keys = "g'" },
    { mode = 'n', keys = '`' },
    { mode = 'n', keys = 'g`' },
    { mode = 'x', keys = "'" },
    { mode = 'x', keys = "g'" },
    { mode = 'x', keys = '`' },
    { mode = 'x', keys = 'g`' },
    -- G key 
    { mode = 'n', keys = 'g' },
    { mode = 'x', keys = 'g' },
    -- Folds
    { mode = 'n', keys = 'z' },
    { mode = 'x', keys = 'z' },
  },
  clues = {
    miniclue.gen_clues.builtin_completion(),
    miniclue.gen_clues.windows(),
    miniclue.gen_clues.registers({ show_contents = true}),
    -- miniclue.gen_clues.builtin_completion(),
    miniclue.gen_clues.marks(),
    miniclue.gen_clues.g(),
    miniclue.gen_clues.z(),
    -- { mode = 'n', keys = '<leader>s', desc='Find word under cursor' },
    -- { mode = 'x', keys = '<leader>s', desc='Find word under cursor' },
    { mode = 'n', keys = '<leader>*', desc='Find word under cursor' },
    { mode = 'n', keys = '<leader>b', desc=' Buffer' },
    { mode = 'n', keys = '<Leader>f', desc = ' Find' },
    { mode = 'n', keys = '<Leader>g', desc = '󰊢 Git/Diff' },
    { mode = 'n', keys = '<Leader>v', desc = ' Vim/NVim' },

    -- { mode = 'n', keys = '<leader>fb', desc='Find buffers' },
    { mode = 'n', keys = '<leader>c', desc='Find commands' },
    -- { mode = 'n', keys = '<leader>fc', desc='Find colorschemes' },
    -- { mode = 'n', keys = '<leader>fh', desc='Find help tags' },
    -- { mode = 'n', keys = '<leader>fm', desc='Find maps' },
  },
  window = {
    config = { anchor = 'NE', row='auto', col='auto', width='auto'},
  },
  delay=300 
})

-- { mode = 'n', keys = '<Leader>b', desc = ' Buffer' },
--             { mode = 'n', keys = '<Leader>f', desc = ' Find' },
--             { mode = 'n', keys = '<Leader>g', desc = '󰊢 Git' },
--             { mode = 'n', keys = '<Leader>i', desc = '󰏪 Insert' },
--             { mode = 'n', keys = '<Leader>l', desc = '󰘦 LSP' },
--             { mode = 'n', keys = '<Leader>q', desc = ' NVim' },
--             { mode = 'n', keys = '<Leader>s', desc = '󰆓 Session' },
--             { mode = 'n', keys = '<Leader>u', desc = '󰔃 UI' },
--             { mode = 'n', keys = '<Leader>w', desc = ' Window' },
