local status, cmp = pcall(require, "cmp")
if (not status) then return end


local has_snip, luasnip = pcall(require, "luasnip")
local has_lspkind, lspkind = pcall(require, 'lspkind')

local cmp_sources = {
  nvim_lsp    = "[LSP]",
  buffer      = "[Buf]",
  treesitter  = "[Trs]",
  path        = "[Pth]",
  luasnip     = "[Snp]",
  nvim_lsp_signature_help = "[Sig]",
}

-- from astrovim
local function has_words_before()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
  end
-- vim.opt.completeopt = "menu,menuone,noinsert,noselect"

cmp.setup({
  preselect = cmp.PreselectMode.None,
  snippet = {
    expand = function(args) if has_snip then luasnip.lsp_expand(args.body) end end 
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

  window = {
    documentation = cmp.config.window.bordered(),
    -- completion = cmp.config.window.bordered(),
  },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = has_lspkind and lspkind.cmp_format({ mode= 'symbol_text', ellipsis_char= '', symbol_map = { Codeium = "", }, }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp_signature_help', priority = 1000 },
    { name = 'nvim_lsp', priority = 800 },
    { name = 'codeium', prioerity = 750 },
    { name = 'luasnip', priority = 700 },
    { name = 'buffer', priority = 600 },
    { name = 'path', priority = 400 },
  }),
  experimental = {
    ghost_text = true,
    -- native_menu = true
  },
})

-- null-ls extras for autompletion
local status, nullls = pcall(require, "null-ls")
if (not status) then return end
local  helpers
nullls.setup({
  debounce = 550,
  save_after_format = false,
  sources = {
--     -- formatting
--     nullls.builtins.formatting.prettierd,
--     nullls.builtins.formatting.shfmt,
    nullls.builtins.formatting.fixjson,
    nullls.builtins.formatting.csharpier,
    nullls.builtins.formatting.markdownlint,

--     -- diagnostics
--     nullls.builtins.diagnostics.tsc,
--     -- nullls.builtins.eslint_d,
--     -- Code Actions
--     -- nullls.builtins.code_actions.gitsign,
--     -- nullls.builtins.gitrebase,
    nullls.builtins.code_actions.proselint,
    require("typescript.extensions.null-ls.code-actions"),
    -- hoveron
    nullls.builtins.hover.dictionary,
    nullls.builtins.hover.printenv,
  },
  root_dir = require'null-ls.utils'.root_pattern ".git",
})
