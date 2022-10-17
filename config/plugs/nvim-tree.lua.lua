local status, nvimtree = pcall(require, 'nvim-tree')
if (not status) then return end

-- For nvim-tree or other filetree pluggins
vim.g.loaded = 1 
vim.g.loaded_netrwPlugin = 1 

nvimtree.setup { 
  disable_netrw = true,
  hijack_netrw = true,
  hijack_cursor = false,
  open_on_setup = false,
  sort_by = "case_sensitive",
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
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
    highlight_opened_files = "none",
    icons = {
      webdev_colors = true
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
  }
}

--# neovim-tree
vim.keymap.set('n', '<leader>nl', ':NvimTreeFindFileToggle<CR>')
vim.keymap.set('n', '<C-B>', ':NvimTreeToggle<CR>')
-- vim.keymap.set("n", "<leader>nn", require("nvim-tree.api").marks.navigate.next)
-- vim.keymap.set("n", "<leader>np", require("nvim-tree.api").marks.navigate.prev)
-- vim.keymap.set("n", "<leader>ns", require("nvim-tree.api").marks.navigate.select())
