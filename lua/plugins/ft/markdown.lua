return {
  { "MeanderingProgrammer/render-markdown.nvim", 
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' },
    ft = { "markdown", "codecompanion" }, 
    opts={ 
      file_types = { "markdown", "codecompanion"},
      render_modes = true, 
      anti_conceal = {
        above = 0,
        below = 1,
      }
    },
  }, 
}
