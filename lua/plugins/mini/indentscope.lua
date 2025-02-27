return {
  { 'echasnovski/mini.indentscope', 
    opts={
      symbol = '┆',
      options = { 
        border = "top", 
        try_as_border = true,
      }, 
    },
    config = function(_, opts)
      local miniindentscope = require('mini.indentscope')
      miniindentscope.setup(opts)

      vim.api.nvim_create_autocmd({ "FileType" }, {
        desc = "Disable indentscope for certain filetypes",
        callback = function()
          local ignore_filetypes = {
            "aerial",
            "avante",
            "dashboard",
            "help",
            "lazy",
            "leetcode.nvim",
            "mason",
            "neo-tree",
            "NvimTree",
            "neogitstatus",
            "notify",
            "startify",
            "toggleterm",
            "Trouble"
          }
          if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
            vim.b.miniindentscope_disable = true
          end
        end,
      })
    end
  }
}
