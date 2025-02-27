return {
  {
    'sainnhe/sonokai',
    lazy = false,
    priority = 1000, -- only main theme should have this prio
    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme sonokai]])
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = true,
    config = function()
      local tokyonight = require "tokyonight"
      tokyonight.setup { style = "storm" }
      tokyonight.load()
    end,
  },
}
