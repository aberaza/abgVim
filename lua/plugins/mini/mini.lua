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
  { import =  'plugins.mini.statusline' },
  { import =  'plugins.mini.diff' },
  { import =  'plugins.mini.files' },
  { import =  'plugins.mini.indentscope' },
  { import =  'plugins.mini.clue' },
  { import =  'plugins.mini.hipatterns' },
}
