return {
  { "MeanderingProgrammer/render-markdown.nvim", 
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },
    ft = { "markdown", "codecompanion", "Avante"}, 
    opts={ 
      -- file_types = { "markdown", "codecompanion", "Avante" },
      render_modes = { 'n', 'c', 't'},  -- normal, command, and terminal modes 
      anti_conceal = {
        above = 0,
        below = 1,
      },
      heading = {
        border = true,

      },
      indent = { 
        enabled = true,
        skipHeading = true,
      }
    },
  }, {
    "brianhuster/live-preview.nvim",
    dependencies = {
      'ibhagwan/fzf-lua',
    }
  }
  
}
