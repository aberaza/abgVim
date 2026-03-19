return {
  { 'echasnovski/mini.files', 
    version = false,
    event = 'VeryLazy',
    keys = {
      { "<leader>e", function() require("mini.files").toggle() end, desc = "Explorer (mini.files)" },
      { "<leader>E", function() require("mini.files").toggle(vim.api.nvim_buf_get_name(0)) end, desc = "Explorer (current file)" },
      { "<C-b>", function() require("mini.files").toggle(vim.fn.getcwd()) end, desc = "Explorer (cwd)" },
      { "-", function() require("mini.files").toggle(vim.fn.getcwd()) end, desc = "Explorer (cwd)" },
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
      -- Toggle dotfiles and git-aware filters
      local show_dotfiles = false
      local git_filter_mode = "all" -- all | tracked | tracked_untracked
      local git_filter_set = nil
      local git_filter_root = nil

      local function build_git_path_set(paths)
        local set = {}
        for _, path in ipairs(paths) do
          if path ~= "" then
            path = path:gsub("\\", "/")
            set[path] = true
            local dir = vim.fn.fnamemodify(path, ":h")
            while dir and dir ~= "." and dir ~= "/" do
              set[dir] = true
              local next_dir = vim.fn.fnamemodify(dir, ":h")
              if next_dir == dir then break end
              dir = next_dir
            end
          end
        end
        return set
      end

      local function git_root_for(cwd)
        local root = vim.fn.systemlist({ "git", "-C", cwd, "rev-parse", "--show-toplevel" })
        if vim.v.shell_error ~= 0 or not root[1] or root[1] == "" then
          return nil
        end
        return root[1]
      end

      local function update_git_filter(mode)
        if mode == "all" then
          git_filter_mode = "all"
          git_filter_set = nil
          git_filter_root = nil
          return true
        end

        local cwd = vim.fn.getcwd()
        local root = git_root_for(cwd)
        if not root then
          vim.notify("MiniFiles: not in a git repo", vim.log.levels.WARN)
          git_filter_mode = "all"
          git_filter_set = nil
          git_filter_root = nil
          return false
        end

        local cmd = { "git", "-C", root, "ls-files" }
        if mode == "tracked_untracked" then
          cmd = { "git", "-C", root, "ls-files", "--cached", "--others", "--exclude-standard" }
        end

        local list = vim.fn.systemlist(cmd)
        if vim.v.shell_error ~= 0 then
          vim.notify("MiniFiles: failed to query git files", vim.log.levels.WARN)
          return false
        end

        git_filter_mode = mode
        git_filter_root = root
        git_filter_set = build_git_path_set(list)
        return true
      end

      local function filter_dotfiles(entry)
        return show_dotfiles or not vim.startswith(entry.name, ".")
      end

      local function filter_git(entry)
        if git_filter_mode == "all" or not git_filter_set or not git_filter_root then
          return true
        end

        local path = entry.path or entry.name
        if path == "" then
          return true
        end

        local abs = vim.fn.fnamemodify(path, ":p")
        local rel = abs
        if vim.startswith(abs, git_filter_root .. "/") then
          rel = abs:sub(#git_filter_root + 2)
        end
        rel = rel:gsub("\\", "/")

        return git_filter_set[rel] == true
      end

      local function current_filter(entry)
        if not filter_dotfiles(entry) then return false end
        if not filter_git(entry) then return false end
        return true
      end

      local function toggle_dotfiles()
        show_dotfiles = not show_dotfiles
        MiniFiles.refresh({ content = { filter = current_filter } })
      end

      local function toggle_git_tracked()
        if git_filter_mode == "tracked" then
          update_git_filter("all")
          vim.notify("MiniFiles: showing all files", vim.log.levels.INFO)
        else
          if update_git_filter("tracked") then
            vim.notify("MiniFiles: showing git tracked files", vim.log.levels.INFO)
          end
        end
        MiniFiles.refresh({ content = { filter = current_filter } })
      end

      local function toggle_git_tracked_untracked()
        if git_filter_mode == "tracked_untracked" then
          update_git_filter("all")
          vim.notify("MiniFiles: showing all files", vim.log.levels.INFO)
        else
          if update_git_filter("tracked_untracked") then
            vim.notify("MiniFiles: showing git tracked + untracked (not ignored)", vim.log.levels.INFO)
          end
        end
        MiniFiles.refresh({ content = { filter = current_filter } })
      end

      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesBufferCreate",
        callback = function(args)
          local buf_id = args.data.buf_id
          vim.keymap.set("n", "g.", toggle_dotfiles, { buffer = buf_id, desc = "Toggle dotfiles" })
          vim.keymap.set("n", "gf", toggle_git_tracked, { buffer = buf_id, desc = "Toggle git tracked files" })
          vim.keymap.set("n", "gi", toggle_git_tracked_untracked, { buffer = buf_id, desc = "Toggle git tracked + untracked" })
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
