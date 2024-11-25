local status, statusline = pcall(require, 'mini.statusline')
if (not status) then return end

local H = {}

H.get_git_info = function(args)
  local win_width = vim.api.nvim_win_get_width(0)
  if args and args.trunc_width and win_width < args.trunc_width then
    return  ' '
  end
  -- get branch name from fugitive 
  return ' '..vim.fn.FugitiveHead()
end

statusline.setup( { 
  content = {
    active = function()
      local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 140 })
      -- local git           = MiniStatusline.section_git({ trunc_width = 40 })
      local git = H.get_git_info({ trunc_width = 110 })

      local diff          = MiniStatusline.section_diff({ trunc_width = 70 })
      local diagnostics   = MiniStatusline.section_diagnostics({ trunc_width = 90 })
      local lsp           = MiniStatusline.section_lsp({ trunc_width = 80 })
      local filename      = MiniStatusline.section_filename({ trunc_width = 120 })
      local fileinfo      = MiniStatusline.section_fileinfo({ trunc_width = 130 })
      local location      = MiniStatusline.section_location({ trunc_width = 130 })
      local search        = MiniStatusline.section_searchcount({ trunc_width = 75 })

      return MiniStatusline.combine_groups({
        { hl = mode_hl,                  strings = { mode } },
        { hl = 'MiniStatuslineDevinfo',  strings = { git, diff, diagnostics, lsp } },
        '%<', -- Mark general truncate point
        { hl = 'MiniStatuslineFilename', strings = { filename } },
        '%=', -- End left alignment
        { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
        { hl = mode_hl,                  strings = { search, location } },
      })
    end,
  },
})

