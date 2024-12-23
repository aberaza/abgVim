return {
  { 'hrsh7th/nvim-cmp',
    event = "BufReadPre",
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-buffer'},
      { 'hrsh7th/cmp-path'},
      { 'hrsh7th/cmp-nvim-lsp-signature-help'},
      { "onsails/lspkind.nvim" },
      { 'MeanderingProgrammer/render-markdown.nvim'},
    },
    opts = function()
      local cmp = require('cmp')
      local lspkind = require('lspkind')
      local conf = require('plugins.cmp.config')

      return {
        window = {
          documentation = cmp.config.window.bordered(),
        },
        experimental = {
          ghost_text = false,
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'path' },
          { name = 'buffer' },
          { name = 'render-markdown' },
        },
        formatting = {
          fields = { 'kind', 'abbr', 'menu' },
          format = lspkind.cmp_format({
            mode = 'symbol',
            ellipsis_char= '', 
            menu = conf.cmp_sources,
            symbol_map = { Codeium = "", Copilot = "" }, 
          })
        },
        mapping = cmp.mapping.preset.insert({}),
      }
    end,
  },
}
