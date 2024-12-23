return {
  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      { "<leader>xx", "<cmd> Trouble diagnostic toggle<cr>", desc = "Diagnostics Toggle (Trouble)" },
    }
  }
}
