-- local H = {}
-- H.get_git_info = function(args)
--   local win_width = vim.api.nvim_win_get_width(0)
--   if args and args.trunc_width and win_width < args.trunc_width then
--     return  ' '
--   end
--   -- get branch name from fugitive 
--   return ' '..vim.fn.FugitiveHead()
-- end


return {
  { 'echasnovski/mini.comment', opts={} },
  { 'echasnovski/mini.cursorword', opts={} },
  { 'echasnovski/mini.surround', opts={} },
  { 'echasnovski/mini.pairs', opts={} },
  { 'echasnovski/mini.extra', opts={} },
  { 'echasnovski/mini.move', opts={} },
  { 'echasnovski/mini.bufremove', opts={} },
  { import =  'plugins.mini' }
  -- spec = { import = 'plugins.mini' },
  -- load mini comment, surround pairs extra move modules
  -- { 'echasnovski/mini.nvim',
  --   dependencies = { 'tpope/vim-fugitive' },
  --   import = 'plugins.mini',
    -- spec = { import = 'plugins.mini' },
    -- config = function()
    --   require('mini.comment').setup()
    --   require('mini.cursorword').setup( { delay = 160 })
    --   require('mini.surround').setup()
    --   require('mini.pairs').setup()
    --   require('mini.extra').setup()
    --   require('mini.move').setup()
    --   require('mini.bufremove').setup()
    --   -- require('plugins.mini.diff').setup()
    --   require('plugins.mini.indentscope').setup()
    --   require('plugins.mini.statusline').setup()
    --   require('plugins.mini.hipatterns').setup()
    --   require('plugins.mini.files').setup()
    --   require('plugins.mini.pick').setup()
    -- end
  -- }
}
