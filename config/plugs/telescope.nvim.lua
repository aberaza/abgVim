local status, telescope = pcall(require, 'telescope')
if (not status) then return end

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
          ['N'] = fb_actions.create,
          ["h"] = fb_actions.goto_parent_dir,
          ["/"] = function() vim.cmd('startinsert') end
        },
      },
    }
  }
}

telescope.load_extension("file_browser")


vim.keymap.set('n', 'ff', builtin.find_files)
vim.keymap.set('n', 'fg', builtin.live_grep)
vim.keymap.set('n', 'fb', builtin.buffers)
vim.keymap.set('n', 'fh', builtin.help_tags)
vim.keymap.set('n', 'fr', builtin.resume)
vim.keymap.set('n', 'fd', builtin.diagnostics)
vim.keymap.set('n', 'ft', telescope.extensions.file_browser.file_browser)

vim.keymap.set('','<C-f>', builtin.live_grep)
