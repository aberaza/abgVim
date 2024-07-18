local ok, neotest = pcall(require, "neotest")
if (not ok) then return end


neotest.setup {
  adapters = {
    require 'neotest-jest',
    require 'neotest-go',
    require("neotest-dotnet")({
      -- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
      dap = { justMyCode = false },
      discovery_root = 'solution'
    })
  }
}

local keymap = vim.keymap
local function desc(description)
local bufopts = { noremap=true, silent=true, desc=description}
return bufopts
end

keymap.set('n', '<leader>tf', "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", desc("TestFile"))
keymap.set('n', '<leader>tfd', "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>", desc("TestFileDAP"))
keymap.set('n', '<leader>tx', '<cmd>TestSuite<CR>', desc("TestSuite"))
keymap.set('n', '<leader>tl', neotest.run.run_last, desc("TestLast"))
keymap.set('n', '<leader>tld', "<cmd>lua require('neotest').run.last({ strategy = 'dap' })<cr>", desc("TestLast"))
keymap.set('n', '<leader>tn', neotest.run.run, desc("TestNearest"))
keymap.set('n', '<leader>tnd', "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", desc("TestNearestDAP"))
keymap.set('n', '<leader>tv', '<cmd>TestVisit<CR>', desc("TestVisit"))
keymap.set('n', '<leader>ta', neotest.run.attach, desc("TestAttach"))
keymap.set('n', '<leader>ts', neotest.run.stop, desc("TestStop"))
keymap.set('n', '<leader>tS', neotest.summary.toggle, desc("TestSummaryToggle"))
keymap.set('n', '<leader>to', neotest.output.open, desc("TestOutput"))

