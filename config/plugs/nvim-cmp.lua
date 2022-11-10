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
  nvim_lsp = "[LSP]",
  buffer = "[Buff]",
  treesitter = "[Trees]",
  path = "[Path]",
  nvim_lsp_signature_help = "[Signature]",
}


cmp.setup({
    snippet = {
        -- use vsnip
        expand = function(args) vim.fn["vsnip#anonymous"](args.body) end,
    },
    mapping = {
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
          vim_item.menu = "   [" .. vim_item.kind .. "]"
          vim_item.kind = " " .. (cmp_kinds[vim_item.kind] or vim_item.kind) .. " "
          return vim_item
        end,
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'path' },
        { name = 'vsnip' },
        { name = 'nvim_lua' },
        { name = 'nvim_lsp_signature_help' },
    }, {}
    ),
    experimental = {
      -- native_menu = true
      ghost_text = true
    }
})

-- Assist on commands that start with / or ?
-- cmp.setup.cmdline({ '/', '?' }, {
--     mapping = cmp.mapping.preset.cmdline(),
--     sources = {
--       { name = 'buffer' }
--     }
--   })

-- Assist on commands that start with :
-- cmp.setup.cmdline(':', {
--     mapping = cmp.mapping.preset.cmdline(),
--     sources = cmp.config.sources({
--       { name = 'path' }
--     }, {
--       { name = 'cmdline' }
--     })
--   })
--   
-- null-ls extras for autompletion
local status, nullls = pcall(require, "null-ls")
if (not status) then return end
nullls.setup({
  debounce = 150,
  save_after_format = false,
  sources = { 
    -- formatting
    nullls.builtins.formatting.prettierd,
    nullls.builtins.formatting.shfmt,
    nullls.builtins.formatting.fixjson,
    -- diagnostics
    nullls.builtins.diagnostics.tsc,
    -- nullls.builtins.eslint_d,
    -- Code Actions
    -- nullls.builtins.code_actions.gitsign,
    -- nullls.builtins.gitrebase,
    -- hover 
    nullls.builtins.hover.dictionary,
  },
  root_dir = require'null-ls.utils'.root_pattern ".git",
})

