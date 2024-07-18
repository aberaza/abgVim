local status, telescope = pcall(require, 'telescope')
if not status then return end

local actions = require('telescope.actions')
local builtin = require('telescope.builtin')
local fb_actions = require('telescope').extensions.file_browser.actions

telescope.setup {
  defaults = {
    mappings = {
      n = {
        ['q'] = actions.close
      },
      i = {
        ["<C-h>"] = "which_key"
      }
    }
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    file_browser = {
      theme = 'dropdown',
      -- replace netrw
      -- hijack_netrw = true
      respect_gitignore = false,
      hidden = true,
      -- directories first
      grouped = true,
      previewer = false,
      mappings = {
        ['i'] = {
          ['<C-w>'] = function() vim.cmd('normal vbd') end,
        },
        ['n'] = {
          ['a'] = fb_actions.create,
          ["u"] = fb_actions.goto_parent_dir,
          ["/"] = function() vim.cmd('startinsert') end
        },
      },
    }
  }
}

telescope.load_extension("file_browser")


vim.keymap.set('n', 'ff', builtin.find_files, { desc = 'Telescope: Find Files'})
vim.keymap.set('n', 'fg', builtin.live_grep, { desc = 'Telescope: Live Grep'})
vim.keymap.set('n', 'fb', builtin.buffers, { desc = 'Telescope: Buffers'})
vim.keymap.set('n', 'fh', builtin.help_tags, { desc = 'Telescope: Tags'})
vim.keymap.set('n', 'fr', builtin.resume, { desc = 'Telescope: Resume'})
vim.keymap.set('n', 'fd', builtin.diagnostics, { desc = 'Telescope: Diagnostics'})
vim.keymap.set('n', 'ft', telescope.extensions.file_browser.file_browser, { desc = 'Telescope: File Browser'})

vim.keymap.set('','<C-f>', builtin.live_grep)
