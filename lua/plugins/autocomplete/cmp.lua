return {
  { 'hrsh7th/nvim-cmp',
    enabled = true,
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
      local conf = require('plugins.autocomplete.config')

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
            symbol_map = { Codeium = " ", Copilot = " " }, 
          })
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c', desc = 'Select Next Completion' }),
          ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c', desc = 'Select Previous Completion' }),
          ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c', desc = 'Scroll Documentation Up' }),
          ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c', desc = 'Scroll Documentation Down' }),
          ['<C-y>'] = cmp.mapping(cmp.mapping.confirm({ select = true }), { 'i', 'c', desc = 'Confirm Completion' }),
          ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c', desc = 'Trigger Completion' }),
          ['<CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true, desc = 'Confirm Selection' }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then cmp.select_next_item()
            -- elseif luasnip.expand_or_jumpable() then luasnip.expand_or_jump()
            else fallback()
            end
          end, { 'i', 's', desc = 'Next Completion or Tab' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then cmp.select_prev_item()
            -- elseif luasnip.jumpable(-1) then luasnip.jump(-1)
            else fallback()
            end
          end, { 'i', 's', desc = 'Previous Completion or Shift-Tab' }), 
        }),
        -- New config items from old config 
      }
    end,
  },
}
