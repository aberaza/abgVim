return {
  { 'echasnovski/mini.files', 
    version = false,
    event = 'VeryLazy',
    keys = {
      { "<leader>e", function() require("mini.files").toggle() end, desc = "Explorer (mini.files)" },
      { "<leader>E", function() require("mini.files").toggle(vim.api.nvim_buf_get_name(0)) end, desc = "Explorer (current file)" },
    },
    opts = {
      mappings = {
        go_in_plus = '<CR>',
        close = 'q',
        reveal_cwd = '@',
        show_help = '?',
        synchronize = '=',
      },
      options = {
        use_as_default_explorer = true, -- if true, will replace netrw
      },
      windows = {
        preview = true,
        width_preview = 60,
        width_focus = 35,
        width_nonfocus = 15,
      },
      content = {
        -- Filter showing files and directories
        -- filter = function(entry, _)
        --   return not vim.startswith(entry.name, ".")
        -- end,
        -- Sort content first by directories then by files
        sort = function(entries)
          -- Entries is an array of items with fields 'fs_type' and 'name'
          local dirs = vim.tbl_filter(function(x) return x.fs_type == 'directory' end, entries)
          local files = vim.tbl_filter(function(x) return x.fs_type == 'file' end, entries)
          
          local function compare_name(a, b) return a.name < b.name end
          table.sort(dirs, compare_name)
          table.sort(files, compare_name)
          
          return vim.list_extend(dirs, files)
        end,
      },
    }, 
    config = function(_, opts)
      require("mini.files").setup(opts)
      
      -- Add some extra functionality
      -- Set highlight for the target path
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "minifiles",
        callback = function()
          vim.api.nvim_set_hl(0, "MiniFilesCursorLine", { link = "Visual" })
          vim.api.nvim_set_hl(0, "MiniFilesNormal", { link = "Normal" })
        end,
      })
      -- Toggle dotfiles filter
      local show_dotfiles = false
      local filter_show = function(fs_entry) return true end

      local filter_hide = function(fs_entry)
        return not vim.startswith(fs_entry.name, '.')
      end

      local toggle_dotfiles = function()
        show_dotfiles = not show_dotfiles
        local new_filter = show_dotfiles and filter_show or filter_hide
        MiniFiles.refresh({ content = { filter = new_filter } })
      end

      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesBufferCreate",
        callback = function(args)
          local buf_id = args.data.buf_id
          vim.keymap.set("n", "g.", toggle_dotfiles, { buffer = buf_id, desc = "Toggle dotfiles" })
        end,
      })
      -- Add a helper function to toggle mini.files
      local minifiles_toggle = function(target_path)
        if not MiniFiles.close() then
          if target_path then
            MiniFiles.open(target_path)
          else
            MiniFiles.open()
          end
        end
      end
      -- Make it available globally
      _G.MiniFiles = require("mini.files")
      _G.MiniFiles.toggle = minifiles_toggle
    end,
  },
}
