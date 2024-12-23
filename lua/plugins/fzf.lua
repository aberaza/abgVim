return {
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { '<C-p>', '<cmd>FzfLua files<cr>', 'n', desc = 'Fuzy File Finder', noremap=true, silent=true },
      { '<leader>ff', '<cmd>FzfLua files!<cr>', 'n', desc = 'Fuzzy File Finder FS', silent=true},
      { '<C-F>', '<cmd>FzfLua grep<cr>', desc = 'Find in files'},
      -- { '<leader>s','<cmd>FzfLua grep_cword<cr>', desc='Find Word under cursor'},
      { '<leader>s','<cmd>FzfLua grep_visual<cr>', desc='Find Word under cursor'},
      { "<leader>,", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "Switch Buffer" },
      { "<leader>fb", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
      { "<leader>fC", "<cmd>FzfLua commands<cr>", desc = "Commands" },
      { "<leader>fc", "<cmd>FzfLua colorschemes<cr>", desc = "Colorschemes" },
      { "<leader>sd", "<cmd>FzfLua diagnostics_document<cr>", desc = "Document Diagnostics" },
      { "<leader>sD", "<cmd>FzfLua diagnostics_workspace<cr>", desc = "Workspace Diagnostics" },
    },
    opts = {
      winopts = {
        height = 0.4,
        preview = {
          horizontal = 'right:55%',
          vertical = 'up:50%',
          layout = 'flex',
          flip_columns = 120, -- Columns to switch from horizontal to vertical on flexo
          scrollchars = { "┃", "" },
        }
      }
    },
  }
}
