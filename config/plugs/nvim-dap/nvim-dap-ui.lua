local status, dapui = pcall(require, "dapui")
if (not status) then return end


dapui.setup({
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
  },
  layouts = {
    {
      elements = {
        { id = "scopes", size = 0.25 },
        { id = "breakpoints", size = 0.20 },
        { id = "stacks", size = 0.25 },
        { id = "watches", size = 0.30 },
      },
      size = 50,
      position = 'right',
    },
    {
      elements = { 'repl' },
      size = 10,
      position = 'bottom',
    },
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 }
})

-- add listeners to auto open DAP UI
local dap = require('dap')
dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end


vim.keymap.set({'n','v'}, '<leader>de', dapui.eval, { desc = 'Evaluate' })
vim.keymap.set('v', '<leader>dE', dapui.eval, { desc = 'Evaluate' })
vim.keymap.set({'n','v'}, '<leader>dU', dapui.toggle, { desc = 'Toggle UI' })
vim.keymap.set({'n','v'}, '<leader>dE', function() dapui.eval(vim.fn.input '[Expression] > ') end, { desc = 'Evaluate Input' })
-- vim.keymap.set({'n','v'}, '<leader>dh', dapui.widgets.hover, { desc = 'Hover Variables' })
-- vim.keymap.set({'n','v'}, '<leader>dS', dapui.widgets.scopes, { desc = 'Scopes' })
