return {
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { '<C-p>', '<cmd>FzfLua files<cr>', 'n', desc = 'Find Files', noremap=true, silent=true },
      { '<C-S-P>' , '<cmd>FzfLua combine pickers=keymaps;commands<cr>', 'n', desc = 'Find Actions', noremap=true, silent=true },
      { '<leader>ff', '<cmd>FzfLua files!<cr>', 'n', desc = 'Find Files (Full Search)', silent=true},
      { '<C-F>', '<cmd>FzfLua grep<cr>', desc = 'Find in Files'},
      -- { '<leader>s','<cmd>FzfLua grep_cword<cr>', desc='Find Word under cursor'},
      { '<leader>s','<cmd>FzfLua grep_visual<cr>', desc='Find Word under Cursor'},
      { "<leader>fb", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "Find Buffers" },
      { "<leader>fC", "<cmd>FzfLua commands<cr>", desc = "Find Commands" },
      { "<leader>fc", "<cmd>FzfLua colorschemes<cr>", desc = "Find Colorscheme" },
      { "<leader>sd", "<cmd>FzfLua diagnostics_document<cr>", desc = "Find Document Diagnostics" },
      { "<leader>sD", "<cmd>FzfLua diagnostics_workspace<cr>", desc = "Find Workspace Diagnostics" },
    },
    opts = {
      file_icon_padding = ' ',
      winopts = {
        height = 0.4,
        preview = {
          horizontal = 'right:55%',
          vertical = 'up:50%',
          layout = 'flex',
          flip_columns = 120, -- Columns to switch from horizontal to vertical on flexo
          scrollchars = { "┃", "" },
        }
      },
      grep = {
        rg_opts = "--hidden --column --line-number --no-heading " ..
                  "--color=always --smart-case " ..
                  "-g '!.git/' -g '!node_modules/' -g '!.tags' -g '!tags' " ..
                  "-g '!*.git*'",
        no_esc = true,     -- Disable escaping for easy regex usage
        git_icons = false, -- Don't show git icons (icons are often noisy)
      },
      files = {
        git_icons = false, -- Disable git icons in files search as well
        fd_opts = "--color=never --type f --hidden --follow " ..
                  "--exclude .git --exclude node_modules",
      }
    },
  }
}
