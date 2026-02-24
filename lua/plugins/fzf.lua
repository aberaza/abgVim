return {
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { '<C-p>', '<cmd>FzfLua files<cr>', 'n', desc = 'Find Files', noremap=true, silent=true },
      { '<C-S-P>' , '<cmd>FzfLua combine pickers=keymaps;commands<cr>', 'n', desc = 'Find Actions', noremap=true, silent=true },
      { '<leader>ff', '<cmd>FzfLua files!<cr>', 'n', desc = 'Find Files (Full Search)', silent=true},
      { '<C-f>', '<cmd>FzfLua grep<cr>', desc = 'Find in Files'},
      -- { '<leader>s','<cmd>FzfLua grep_cword<cr>', desc='Find Word under cursor'},
      { '<leader>,', '<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>', desc = 'Find Buffers'},
      { '<leader>s','<cmd>FzfLua grep_visual<cr>', desc='Find Word under Cursor'},
      { "<leader>fb", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "Find Buffers" },
      { "<leader>fC", "<cmd>FzfLua commands<cr>", desc = "Find Commands" },
      { "<leader>fc", "<cmd>FzfLua colorschemes<cr>", desc = "Find Colorscheme" },
      { "<leader>sd", "<cmd>FzfLua diagnostics_document<cr>", desc = "Find Document Diagnostics" },
      { "<leader>sD", "<cmd>FzfLua diagnostics_workspace<cr>", desc = "Find Workspace Diagnostics" },
    },
    opts = function(_, opts)
      local actions = require("fzf-lua.actions")
      return {
        {"border-fused"},
        file_icon_padding = ' ',
        defaults = {
          formatter = "path.dirname_first",
          git_icons = false, -- Don't show git icons (icons are often noisy)
        },
        oldfiles = {
          include_current_session = true,
        },
        previewers = {
          builtin = {
            syntax_limit_b = 1024 * 100, -- 100 KB
          },
        },
        winopts = {
          title_pos = "left",
          border = 'solid', --rounded,  bold, double, none, rounded, shadow, single, solid
          preview = {
            border = 'solid',
            flip_columns = 120, -- Columns to switch from horizontal to vertical on flexo
            -- scrollchars = { "┃", "" },
          }
        },
        grep = {
          rg_opts = "--hidden --column --line-number --no-heading " ..
          "--color=always --smart-case " ..
          "-g '!.git/' -g '!node_modules/' -g '!.tags' -g '!tags' " ..
          "-g '!*.git*'",
          no_esc = true,     -- Disable escaping for easy regex usage
        },
        files = {
          fd_opts = "--color=never --type f --hidden --follow " ..
          "--exclude .git --exclude node_modules",
        },
        lsp = {
          symbols = {
            symbol_hl = function(s)
              return "TroubleIcon" .. s
            end,
            symbol_fmt = function(s)
              return s:lower() .. "\t"
            end,
            child_prefix = false,
          },
          code_actions = {
            previewer = vim.fn.executable("delta") and "codeaction_native" or nil,
          },
        },
      }
    end,
  }
}
