return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'theHamsta/nvim-dap-virtual-text',
      'rcarriga/nvim-dap-ui',
      'nvim-neotest/nvim-nio',
      'jay-babu/mason-nvim-dap.nvim',
    },
    lazy = true,
    config = function()
      local signs = require('config.utils').dap
      local dap = require('dap')
      local dapui = require('dapui')

      -- Load all debug configurations
      local jsConf = require('plugins.debug.config.js-debug')
      local dotnetConf = require('plugins.debug.config.dotnet-debug')
      local goConf = require('plugins.debug.config.go-debug')

      -- Signs
      for name, icon in pairs({
        DapBreakpoint          = { text = signs.Breakpoint,          texthl = 'DiagnosticError' },
        DapBreakpointCondition = { text = signs.BreakpointCondition, texthl = 'DiagnosticError' },
        DapLogPoint            = { text = signs.LogPoint,            texthl = 'DiagnosticHint' },
        DapStopped             = { text = signs.Stopped,             texthl = 'DiagnosticInfo', linehl = 'DiagnosticUnderlineInfo', numhl = 'DiagnosticInfo' },
        DapBreakpointRejected  = { text = signs.Rejected,            texthl = 'DiagnosticHint' },
      }) do
        vim.fn.sign_define(name, icon)
      end

      -- Register all adapters
      local all_configs = { jsConf, dotnetConf, goConf }
      for _, conf in ipairs(all_configs) do
        for k, v in pairs(conf.adapters) do
          dap.adapters[k] = v
        end
        for k, v in pairs(conf.configurations) do
          dap.configurations[k] = v
        end
      end

      -- DAP-UI setup
      dapui.setup({
        icons = { expanded = '▾', collapsed = '▸', current_frame = '▸' },
        layouts = {
          {
            elements = {
              { id = 'scopes', size = 0.35 },
              { id = 'breakpoints', size = 0.15 },
              { id = 'stacks', size = 0.25 },
              { id = 'watches', size = 0.25 },
            },
            size = 40,
            position = 'left',
          },
          {
            elements = {
              { id = 'repl', size = 0.5 },
              { id = 'console', size = 0.5 },
            },
            size = 0.25,
            position = 'bottom',
          },
        },
      })

      -- Auto open/close DAP-UI
      dap.listeners.after.event_initialized['dapui_config'] = function() dapui.open() end
      dap.listeners.before.event_terminated['dapui_config'] = function() dapui.close() end
      dap.listeners.before.event_exited['dapui_config'] = function() dapui.close() end

      -- Virtual text
      require('nvim-dap-virtual-text').setup({
        commented = true,
      })
    end,
    keys = {
      -- Execution
      { '<leader>dc', function() require('dap').continue() end, mode = 'n', desc = 'Continue / Start', noremap = true, silent = true },
      { '<leader>di', function() require('dap').step_into() end, mode = 'n', desc = 'Step Into', noremap = true, silent = true },
      { '<leader>do', function() require('dap').step_over() end, mode = 'n', desc = 'Step Over', noremap = true, silent = true },
      { '<leader>du', function() require('dap').step_out() end, mode = 'n', desc = 'Step Out', noremap = true, silent = true },
      { '<leader>db', function() require('dap').step_back() end, mode = 'n', desc = 'Step Back', noremap = true, silent = true },
      { '<leader>dR', function() require('dap').run_to_cursor() end, mode = { 'n', 'v' }, desc = 'Run to Cursor', noremap = true, silent = true },

      -- Breakpoints
      { '<leader>dt', function() require('dap').toggle_breakpoint() end, mode = { 'n', 'v' }, desc = 'Toggle Breakpoint', noremap = true, silent = true },
      { '<leader>dC', function() require('dap').set_breakpoint(vim.fn.input('[Condition] > ')) end, mode = 'n', desc = 'Conditional Breakpoint', noremap = true, silent = true },
      { '<leader>dL', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, mode = 'n', desc = 'Log Point', noremap = true, silent = true },

      -- Session management
      { '<leader>dr', function() require('dap').repl.toggle() end, mode = 'n', desc = 'Toggle REPL', noremap = true, silent = true },
      { '<leader>dg', function() require('dap').session() end, mode = 'n', desc = 'Get Session', noremap = true, silent = true },
      { '<leader>dd', function() require('dap').disconnect() end, mode = 'n', desc = 'Disconnect', noremap = true, silent = true },
      { '<leader>dx', function() require('dap').terminate() end, mode = 'n', desc = 'Terminate', noremap = true, silent = true },
      { '<leader>dq', function() require('dap').close() end, mode = 'n', desc = 'Quit', noremap = true, silent = true },

      -- DAP-UI
      { '<leader>dU', function() require('dapui').toggle() end, mode = 'n', desc = 'Toggle DAP UI', noremap = true, silent = true },
      { '<leader>de', function() require('dapui').eval() end, mode = { 'n', 'v' }, desc = 'Eval Expression', noremap = true, silent = true },
    },
  },
  {
    'jay-babu/mason-nvim-dap.nvim',
    dependencies = { 'williamboman/mason.nvim' },
    cmd = { 'DapInstall', 'DapUninstall' },
    opts = {
      ensure_installed = { 'js', 'coreclr', 'delve' },
      automatic_installation = true,
      handlers = {},
    },
  },
}

