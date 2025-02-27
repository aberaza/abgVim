return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      -- add adapter for neotest
      "nvim-neotest/neotest-vim-test",
      "haydenmeade/neotest-jest",
      "marilari88/neotest-vitest",
      "markemmons/neotest-deno",
      "Issafalcon/neotest-dotnet",
    },
    keys = {
      {'<leader>tf', "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", mode='n', desc = "Test File"},
      {'<leader>tfd', "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>", mode='n', desc = "Test File with DAP"},
      {'<leader>tx', "<cmd>TestSuite<CR>", mode='n', desc = "Test Suite"},
      {'<leader>tl', "<cmd>lua require('neotest').run.run_last()<CR>", mode='n', desc = "Test Last"},
      {'<leader>tld', "<cmd>lua require('neotest').run.last({ strategy = 'dap' })<cr>", mode='n', desc = "Test Last with DAP"},
      {'<leader>tn', "<cmd>lua require('neotest').run.run()<CR>", mode='n', desc = "Test Nearest"},
      {'<leader>tnd', "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", mode='n', desc = "Test Nearest with DAP"},
      {'<leader>tv', "<cmd>TestVisit<CR>", mode='n', desc = "Test Visit"},
      {'<leader>ta', "<cmd>lua require('neotest').run.attach()<CR>", mode='n', desc = "Test Attach"},
      {'<leader>ts', "<cmd>lua require('neotest').run.stop()<CR>", mode='n', desc = "Test Stop"},
      {'<leader>tS', "<cmd>lua require('neotest').summary.toggle()<CR>", mode='n', desc = "Toggle Test Summary"},
      {'<leader>to', "<cmd>lua require('neotest').output.open()<CR>", mode='n', desc = "Test Output"},
    }, 
    opts = {
      -- Can be a list of adapters like what neotest expects,
      -- or a table of adapter names, mapped to adapter configs.
      -- The adapter will then be automatically loaded with the config.
      adapters = {
        ["neotest-deno"] = {},
        ["neotest-jest"] = {},
        ["neotest-vitest"] = {},
        ["neotest-vim-test"] = {
          ignore_file_types = { "python", "vim", "lua", "go", "rust" },
        },
        ["neotest-dotnet"] = {},
      },
    },
  },
}
