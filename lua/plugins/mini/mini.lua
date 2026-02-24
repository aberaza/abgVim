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
  { 'nvim-mini/mini.comment', opts={} },
  { 'nvim-mini/mini.cursorword', opts={} },
  { 'nvim-mini/mini.surround', opts={} },
  { 'nvim-mini/mini.pairs', opts={} },
  { 'nvim-mini/mini.extra', opts={} },
  { 'nvim-mini/mini.move', opts={} },
  { 'nvim-mini/mini.bufremove', opts={} },
  {
    'nvim-mini/mini.pick',
    version = false,
    opts = {},
    config = function(_, opts)
      local ok, pick = pcall(require, 'mini.pick')
      if not ok then
        return
      end

      vim.ui.select = pick.ui_select

      pick.setup(vim.tbl_deep_extend('force', opts or {}, {
        window = {
          config = function()
            local height = math.floor(vim.o.lines * 0.80)
            local width = math.floor(vim.o.columns * 0.90)
            return {
              relative = 'editor',
              anchor = 'NW',
              row = math.floor((vim.o.lines - height) / 2),
              col = math.floor((vim.o.columns - width) / 2),
              width = width,
              height = height,
              border = 'rounded',
            }
          end,
          prompt_prefix = '   ',
        },
      }))

      -- Use semantic links so it adapts to any colorscheme
      local function set_pick_highlights()
        vim.api.nvim_set_hl(0, 'MiniPickPrompt', { link = 'Title' })
        vim.api.nvim_set_hl(0, 'MiniPickPromptCaret', { link = 'Special' })
        vim.api.nvim_set_hl(0, 'MiniPickMatchCurrent', { link = 'IncSearch' })
        vim.api.nvim_set_hl(0, 'MiniPickMatchMarked', { link = 'Search' })
        vim.api.nvim_set_hl(0, 'MiniPickMatchRanges', { link = 'Substitute' })
      end

      set_pick_highlights()
      vim.api.nvim_create_autocmd('ColorScheme', { callback = set_pick_highlights })

      pick.registry.colorschemes = function()
        local colorschemes = vim.fn.getcompletion('', 'color')
        return pick.start({
          source = {
            name = 'Colorschemes',
            items = colorschemes,
            choose = function(item)
              pcall(function()
                vim.cmd('colorscheme ' .. item)
              end)
            end,
            preview = function(buf_id, item)
              pcall(function()
                vim.cmd('colorscheme ' .. item)
              end)
              vim.api.nvim_buf_set_lines(buf_id, 0, -1, false, { item })
            end,
          },
        })
      end

      local map_opts = { noremap = true, silent = true }
      vim.keymap.set({ 'n', 'v' }, "<leader>fbs", "<cmd>Pick buf_lines scope='current'<CR>", vim.tbl_extend('force', map_opts, { desc = 'Search buffer' }))
    end,
  },
  -- { import =  'plugins.mini.statusline' },
  -- { import =  'plugins.mini.diff' },
  -- { import =  'plugins.mini.files' },
  -- { import =  'plugins.mini.indentscope' },
  -- { import =  'plugins.mini.clue' },
  -- { import =  'plugins.mini.hipatterns' },
}
