local status, cmp = pcall(require, "cmp")
if (not status) then return end

local H = {}

local cmp_sources = {
  nvim_lsp    = "[LSP]",
  buffer      = "[Buf]",
  treesitter  = "[Trs]",
  path        = "[Pth]",
  luasnip     = "[Snp]",
  nvim_lsp_signature_help = "[Sig]",
}

local has_snip, luasnip = pcall(require, "luasnip")
local has_lspkind, lspkind = pcall(require, 'lspkind')
local has_copilot, copilot = pcall(require, 'copilot_cmp')
if has_copilot then copilot.setup() end

--
-- from astrovim
local function has_words_before()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end
-- vim.opt.completeopt = "menu,menuone,noinsert,noselect"

cmp.setup({
  preselect = cmp.PreselectMode.None,
  snippet = {
    expand = function(args) luasnip.lsp_expand(args.body) end,
  },
  window = {
    documentation = cmp.config.window.bordered(),
    -- completion = cmp.config.window.bordered(),
  },
  duplicates = { 
    nvim_lsp = 1, luasnip = 1, buffer = 1, path = 1,
  },
  mapping = {
    ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
    ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
    ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
    ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close(), }),
    ['<CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    -- ['<Tab>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }), -- Accept currently selected item  
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then luasnip.expand_or_jump()
      elseif has_words_before() then cmp.complete()
      else fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then luasnip.jump(-1)
      else fallback()
      end
    end, { 'i', 's' }), 
  },

  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = lspkind.cmp_format(
      { mode= 'symbol', 
        ellipsis_char= '', 
        menu = cmp_sources,
        symbol_map = { Codeium = "", Copilot = "" }, 
      }),
  },
  sources = cmp.config.sources({
      { name = 'nvim_lsp_signature_help', priority = 1000, group_index = 2},
      { name = 'nvim_lsp', priority = 800, group_index = 2 },
      { name = 'copilot', priority = 780, group_index = 2 },
      { name = 'codeium', priority = 750, group_index = 2  },
      { name = 'luasnip', priority = 700, group_index = 2  },
      { name = 'path', priority = 400, group_index = 2  },
    }, {
      { name = 'buffer', priority = 600 },
    }),
  experimental = {
    ghost_text = true,
    -- native_menu = true
  },
})

vim.api.nvim_set_hl(0, "CmpItemKindCopilot", {fg ="#6CC644"})
-- null-ls extras for autompletion
return H 
