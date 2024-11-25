local status, nvimtree = pcall(require, 'nvim-tree')
if (not status) then return end

-- For nvim-tree or other filetree pluggins
vim.g.loaded = 1 
vim.g.loaded_netrwPlugin = 1 

nvimtree.setup({ 
  disable_netrw = false,
  hijack_netrw = false,
  hijack_cursor = false,
  sort_by = 'case_sensitive',
  sync_root_with_cwd = true,
  -- respect_buf_cwd = true,
  update_cwd = true,
  update_focused_file = {
    enable = true,
    update_cwd = false,
  },
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
  view = {
    adaptive_size = false,
    side = 'left',
    preserve_window_proportions = true,
    width = 30
    -- width = math.floor(vim.fn.winwidth(0) * 0.15), -- Finding 15% of windows width.
  },
  renderer = {
    root_folder_label = false,
    group_empty = true,
    highlight_opened_files = "none",
    highlight_git = false,
    icons = {
      webdev_colors = true,
      show = {
        git = false
      },
      glyphs = {
        default = "󰈚",
        symlink = "",
        folder = {
          default = "",
          empty = "",
          empty_open = "",
          open = "",
          symlink = "",
          symlink_open = "",
          arrow_open = "",
          arrow_closed = "",
        },
        git = {
          unstaged = "✗",
          staged = "✓",
          unmerged = "",
          renamed = "➜",
          untracked = "★",
          deleted = "",
          ignored = "◌",
        },
      },
    },
    indent_markers = {
      enable = false
    },
  },
  filters = {
    dotfiles = true,
  },
  actions = {
    change_dir = {
      enable = false,
      restrict_above_cwd = true,
    },
    open_file = {
      quit_on_open = true,
    }
  },
  diagnostics = {
    enable = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  git = {
    enable = true,
    ignore = false,
    timeout = 500,
  },
})

--# neovim-tree
vim.keymap.set('n', '<leader>nl', ':NvimTreeFindFileToggle<CR>', { desc = 'Filetree Toggle & find'})
vim.keymap.set('n', '<C-B>', ':NvimTreeToggle<CR>', { desc = 'Filetree Toggle'})
