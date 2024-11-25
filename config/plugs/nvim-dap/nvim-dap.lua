local status, dap = pcall(require, "dap")
if (not status) then return end

local dap_breakpoint = {
    breakpoint = {
      text = " ",
      texthl = "LspDiagnosticsSignError",
      linehl = "",
      numhl = "",
    },
    condbreak = {
      text = "",
      texthl = "LspDiagnosticsSignError",
      linehl = "",
      numhl = "",
    },
    logpoint = {
      text = "",
      texthl = "LspDiagnosticsSignHint",
      linehl = "",
      numhl = "",
    },
    rejected = {
      text = "",
      texthl = "LspDiagnosticsSignHint",
      linehl = "",
      numhl = "",
    },
    stopped = {
      text = "",
      texthl = "LspDiagnosticsSignInformation",
      linehl = "DiagnosticUnderlineInfo",
      numhl = "LspDiagnosticsSignInformation",
    },
  }

vim.fn.sign_define("DapBreakpoint", dap_breakpoint.breakpoint)
vim.fn.sign_define("DapBreakpointCondition", dap_breakpoint.condbreak)
vim.fn.sign_define("DapLogPoint", dap_breakpoint.logpoint)
vim.fn.sign_define("DapStopped", dap_breakpoint.stopped)
vim.fn.sign_define("DapBreakpointRejected", dap_breakpoint.rejected)


-- -- Keymaps
vim.keymap.set({'n','v'}, '<leader>dR', dap.run_to_cursor, { desc = 'Run to Cursor'} )
vim.keymap.set({'n','v'}, '<leader>db', dap.step_back, { desc = 'Step Back' })
vim.keymap.set({'n','v'}, '<leader>dc', dap.continue, { desc = 'Continue' })
vim.keymap.set({'n','v'}, '<leader>dd', dap.disconnect, { desc = 'Disconnect' })
vim.keymap.set({'n','v'}, '<leader>dg', dap.session, { desc = 'Get Session' })
vim.keymap.set({'n','v'}, '<leader>di', dap.step_into, { desc = 'Step Into' })
-- vim.keymap.set({'n','v'}, '<leader>dp', dap.pause.toggle, { desc = 'Pause' })
vim.keymap.set({'n','v'}, '<leader>do', dap.step_over, { desc = 'Step Over' })
vim.keymap.set({'n','v'}, '<leader>dq', dap.close, { desc = 'Quit' })
vim.keymap.set({'n','v'}, '<leader>ds', dap.continue, { desc = 'Start' })
vim.keymap.set({'n','v'}, '<leader>dx', dap.terminate, { desc = 'Terminate' })

vim.keymap.set({'n','v'}, '<leader>dC', function() dap.set_breakpoint(vim.fn.input '[Condition] > ') end, { desc = 'Conditional Breakpoint' })

  -- local whichkey = require "which-key"
vim.keymap.set({'n','v'}, '<leader>dr', dap.repl.toggle, { desc = 'Toggle Repl' })
vim.keymap.set({'n','v'}, '<leader>dt', dap.toggle_breakpoint, { desc = 'Toggle Breakpoint' })
vim.keymap.set({'n','v'}, '<leader>du', dap.step_out, { desc = 'Step Out' })
local status, dapui = pcall(require, "dapui")
if (status) then
end

