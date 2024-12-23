return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { '<leader>nl', '<cmd>NvimTreeFindFileToggle<CR>', 'n', desc='FileTree Toggle & Find', noremap = true, silent = true },
    { '<C-b>', '<cmd>NvimTreeToggle<CR>', 'n', desc='FileTree Toggle', noremap = true, silent = true },
  },
  init = function()
    vim.g.loaded = 1
    vim.g.loaded_netrwPlugin = 1
  end,
  opts = {
    disable_netrw = false,
    hijack_netrw = false,
    sort_by = 'case_sensitive',
    sync_root_with_cwd = true,
    update_cwd = true,
    update_focused_file = {
      enable = true,
      update_cwd = false,
    },
    renderer = {
      root_folder_label = false,
      group_empty = true,
      highlight_opened_files = "none",
      highlight_git = false,
      icons = {
        webdev_colors = true,
        show = {
          git = false,
        },
      },
      indent_markers = {
        enable = false,
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
      },
    },
  },
}
