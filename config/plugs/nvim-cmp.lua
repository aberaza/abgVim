local status, cmp = pcall(require, "cmp")
if (not status) then return end

local cmp_kinds =  {
  Text = "",
  Method = "",
  Function = "",
  Constructor = "",
  Field = "ﰠ",
  Variable = "",
  Class = "ﴯ",
  Interface = "",
  Module = "",
  Property = "ﰠ",
  Unit = "塞",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "פּ",
  Event = "",
  Operator = "",
  TypeParameter = "",
}

local cmp_sources = {
  nvim_lsp  = "[LSP]",
  buffer    = "[Buf]",
  treesitter = "[Trs]",
  path      = "[Pth]",
  vsnip     = "[Snp]",
  nvim_lsp_signature_help = "[Sig]",
}


-- set this in eiitor config file
-- vim.opt.completeopt = "menu,menuone,noinsert,noselect"

cmp.setup({
    preselect = cmp.PreselectMode.None,
    snippet = {
        expand = function(args) vim.fn["vsnip#anonymous"](args.body) end,
    },
    mapping = {
        ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
        ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
        ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
        ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
        ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        ['<CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ['<Tab>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }), -- Accept currently selected item  
    },
    window = {
      documentation = cmp.config.window.bordered(),
    },
    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
          -- vim_item.menu = (cmp_sources[entry.source.name] or "")
          vim_item.menu = "  " .. cmp_sources[entry.source.name] 
          vim_item.kind = " " .. (cmp_kinds[vim_item.kind] or vim_item.kind) .. " "
          return vim_item
        end,
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp_signature_help' },
        { name = 'nvim_lsp' },
        { name = 'vsnip' },
        { name = 'path' },
      }, {
        { name = 'buffer' },
        -- { name = 'nvim_lua' }, nvim lua api
    }),
    experimental = {
      ghost_text = true,
      -- native_menu = true
    },
})

-- null-ls extras for autompletion
-- local status, nullls = pcall(require, "null-ls")
-- if (not status) then return end
-- nullls.setup({
--   debounce = 150,
--   save_after_format = false,
--   sources = { 
--     -- formatting
--     nullls.builtins.formatting.prettierd,
--     nullls.builtins.formatting.shfmt,
--     nullls.builtins.formatting.fixjson,
--     -- diagnostics
--     nullls.builtins.diagnostics.tsc,
--     -- nullls.builtins.eslint_d,
--     -- Code Actions
--     -- nullls.builtins.code_actions.gitsign,
--     -- nullls.builtins.gitrebase,
--     -- hover 
--     nullls.builtins.hover.dictionary,
--   },
--   root_dir = require'null-ls.utils'.root_pattern ".git",
-- })

