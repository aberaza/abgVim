return {
  { 
    'mfussenegger/nvim-dap', 
     dependencies = {
       "theHamsta/nvim-dap-virtual-text",
       -- "jay-babu/mason-nvim-dap.nvim",
     },
     lazy = true,
     event = 'VeryLazy',
     config = function()
       local signs = require'config.utils'.dap
       local dap = require'dap'
       local jsConf = require'plugins.debug.config.js-debug'
       
       vim.fn.sign_define("DapBreakpoint", { text = signs.Breakpoint, texthl="LspDiagnosticsSignError", linehl="", numhl=""})
       vim.fn.sign_define("DapBreakpointCondition", { text = signs.BreakpointCondition, texthl="LspDiagnosticsSignError", linehl="", numhl=""})
       vim.fn.sign_define("DapLogPoint", { text = signs.LogPoint, texthl="LspDiagnosticsSignHint", linehl="", numhl=""})
       vim.fn.sign_define("DapStopped", { text = signs.Stopped, texthl="LspDiagnosticsSignInformation", linehl="DiagnosticUnderlineInfo", numhl="LspDiagnosticsSignInformation"})
       vim.fn.sign_define("DapBreakpointRejected", { text = signs.Rejected, texthl="LspDiagnosticsSignHint", linehl="", numhl=""})

       -- for each key - value in jsConf.adapters set dap.adapters[key] = value
       for k, v in pairs(jsConf.adapters) do
          dap.adapters[k] = v
       end
       for k,v in pairs(jsConf.configurations) do
          dap.configurations[k] = v
       end
     end,
      keys = {
        -- Normal mode only - debug operations that make sense in normal mode
        { "<leader>dR", function() require'dap'.run_to_cursor() end, "n", desc = "Run to Cursor", noremap=true, silent=true},
        { "<leader>db", function() require'dap'.step_back() end, "n", desc = "Step Back", noremap=true, silent=true},
        { "<leader>dc", function() require'dap'.continue() end, "n", desc = "Continue", noremap=true, silent=true},
        { "<leader>dd", function() require'dap'.disconnect() end, "n", desc = "Disconnect", noremap=true, silent=true},
        { "<leader>dg", function() require'dap'.session() end, "n", desc = "Get Session", noremap=true, silent=true},
        { "<leader>di", function() require'dap'.step_into() end, "n", desc = "Step Into", noremap=true, silent=true},
        { "<leader>do", function() require'dap'.step_over() end, "n", desc = "Step Over", noremap=true, silent=true},
        { "<leader>dq", function() require'dap'.close() end, "n", desc = "Quit", noremap=true, silent=true},
        { "<leader>ds", function() require'dap'.continue() end, "n", desc = "Start", noremap=true, silent=true},
        { "<leader>dx", function() require'dap'.terminate() end, "n", desc = "Terminate", noremap=true, silent=true},
        { "<leader>dC", function() require'dap'.set_breakpoint(vim.fn.input '[Condition] > ') end, "n", desc = "Conditional Breakpoint", noremap=true, silent=true},
        { "<leader>dr", function() require'dap'.repl.toggle() end, "n", desc = "Toggle Repl", noremap=true, silent=true},
        { "<leader>dt", function() require'dap'.toggle_breakpoint() end, "n", desc = "Toggle Breakpoint", noremap=true, silent=true},
        { "<leader>du", function() require'dap'.step_out() end, "n", desc = "Step Out", noremap=true, silent=true},
        
        -- Visual mode only - operations that make sense for selections
        { "<leader>dR", function() require'dap'.run_to_cursor() end, "v", desc = "Run to Cursor", noremap=true, silent=true},
        { "<leader>dt", function() require'dap'.toggle_breakpoint() end, "v", desc = "Toggle Breakpoint", noremap=true, silent=true},
      }
   },
   -- { 
   --   "rcarriga/nvim-dap-ui", 
   --   lazy = true,
   --   event = 'VeryLazy',
   --   dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"} 
   -- },
   -- {
   --   "jay-babu/mason-nvim-dap.nvim",
   --    dependencies = {"williamboman/mason.nvim"},
   --    config = function()
   --      require'mason-nvim-dap'.setup({
   --        ensure_installed = {"node2", "chrome", "firefox", "js", "coreclr"},
   --      })
   --    end
   -- }

}

