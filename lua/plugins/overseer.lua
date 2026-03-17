return {
  {
    'stevearc/overseer.nvim',
    version = false,
    cmd = {
      'OverseerRun',
      'OverseerToggle',
      'OverseerBuild',
      'OverseerClose',
      'OverseerOpen',
      'OverseerInfo',
      'OverseerClearCache',
    },
    keys = {
      { '<leader>ot', '<cmd>OverseerToggle<cr>',    desc = 'Overseer: Toggle Task List' },
      { '<leader>or', '<cmd>OverseerRun<cr>',        desc = 'Overseer: Run Task' },
      { '<leader>ob', '<cmd>OverseerBuild<cr>',      desc = 'Overseer: Build' },
      { '<leader>oi', '<cmd>OverseerInfo<cr>',       desc = 'Overseer: Info' },
      { '<leader>oq', '<cmd>OverseerClose<cr>',      desc = 'Overseer: Close' },
      { '<leader>ol', function()
          -- Re-run the most recent task
          local overseer = require('overseer')
          local tasks = overseer.list_tasks({ recent_first = true })
          if vim.tbl_isempty(tasks) then
            vim.notify('No recent Overseer tasks', vim.log.levels.WARN)
          else
            overseer.run_action(tasks[1], 'restart')
          end
        end,
        desc = 'Overseer: Restart Last Task',
      },
    },
    opts = {
      -- Use a floating window for the task list (minimalist aesthetic)
      task_list = {
        direction = 'bottom',
        min_height = 10,
        max_height = 20,
        default_detail = 1,
        bindings = {
          ['<CR>']  = 'RunAction',
          ['<C-e>'] = 'Edit',
          ['o']     = 'Open',
          ['p']     = 'TogglePreview',
          ['<C-l>'] = 'IncreaseDetail',
          ['<C-h>'] = 'DecreaseDetail',
          ['L']     = 'IncreaseAllDetail',
          ['H']     = 'DecreaseAllDetail',
          ['q']     = 'Close',
        },
      },

      -- Use mini icons if available for a cleaner look
      component_aliases = {
        default = {
          { 'display_duration', detail_level = 2 },
          'on_output_summarize',
          'on_exit_set_status',
          'on_complete_notify',
          'on_complete_dispose',
        },
      },

      -- Pre-wire common build tasks for the languages we use
      -- These supplement any .overseer.json or tasks.json in the project root.
      templates = {
        'builtin',   -- includes make, cargo, npm, shell, etc.
        'user',      -- user-defined templates from ~/.config/nvim/overseer/
      },
    },

    config = function(_, opts)
      local overseer = require('overseer')
      overseer.setup(opts)

      -- Register project-specific quick-run tasks
      -- These are language-detected shortcuts bound to <leader>ob (Build)
      -- and can be overridden by a project-local .overseer.json.
      overseer.register_template({
        name = 'npm: build',
        condition = {
          callback = function(_)
            return vim.fn.filereadable('package.json') == 1
          end,
        },
        builder = function()
          return { cmd = { 'npm', 'run', 'build' } }
        end,
        priority = 60,
        tags = { overseer.TAG.BUILD },
      })

      overseer.register_template({
        name = 'npm: dev',
        condition = {
          callback = function(_)
            return vim.fn.filereadable('package.json') == 1
          end,
        },
        builder = function()
          return { cmd = { 'npm', 'run', 'dev' } }
        end,
        priority = 55,
        tags = { overseer.TAG.RUN },
      })

      overseer.register_template({
        name = 'dotnet: build',
        condition = {
          callback = function(_)
            return #vim.fn.glob('*.sln', false, true) > 0
              or #vim.fn.glob('*.csproj', false, true) > 0
          end,
        },
        builder = function()
          return { cmd = { 'dotnet', 'build' } }
        end,
        priority = 60,
        tags = { overseer.TAG.BUILD },
      })

      overseer.register_template({
        name = 'dotnet: run',
        condition = {
          callback = function(_)
            return #vim.fn.glob('*.csproj', false, true) > 0
          end,
        },
        builder = function()
          return { cmd = { 'dotnet', 'run' } }
        end,
        priority = 55,
        tags = { overseer.TAG.RUN },
      })

      overseer.register_template({
        name = 'go: build',
        condition = {
          callback = function(_)
            return vim.fn.filereadable('go.mod') == 1
          end,
        },
        builder = function()
          return { cmd = { 'go', 'build', './...' } }
        end,
        priority = 60,
        tags = { overseer.TAG.BUILD },
      })

      overseer.register_template({
        name = 'go: run',
        condition = {
          callback = function(_)
            return vim.fn.filereadable('go.mod') == 1
          end,
        },
        builder = function()
          return { cmd = { 'go', 'run', '.' } }
        end,
        priority = 55,
        tags = { overseer.TAG.RUN },
      })
    end,
  },
}
