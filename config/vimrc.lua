
-- Basic LSP config
local nvim_lsp = require('lspconfig')

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = { "documentation", "detail", "additionalTextEdits" },
}
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)


local function on_attach(client, bufnr)
  print('Attached to ' .. client.name)
  -- Enable completion triggered by <C-X><C-O>
  -- See `:help omnifunc` and `:help ins-completion` for more information.
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  -- Use LSP as the handler for formatexpr.
  -- See `:help formatexpr` for more information.
  vim.api.nvim_buf_set_option(0, "formatexpr", "v:lua.vim.lsp.formatexpr()")
  -- Configure key mappings
  -- require("config.lsp.keymaps").setup(client, bufnr)
end

local servers = { 'tsserver', 'jsonls', 'html', 'elmls', 'gopls', 'vimls' }

for _, lsp in pairs(servers) do
    nvim_lsp[lsp].setup ({
        capabilities = capabilities,
        on_attach = on_attach,
        flags = {
            -- default in neovim 0.7+
            debounce_text_changes = 150, 
        },
    })
end

-- CMP autocomplete engine
local cmp = require'cmp'
cmp.setup({
    snippet = {
        expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    end,
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
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    },
    documentation = {
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
      winhighlight = "NormalFloat:NormalFloat,FloatBorder:TelescopeBorder",
    },
    formatting = {
        format = function(entry, vim_item)
          vim_item.menu = ({
            nvim_lsp = "[LSP]",
            buffer = "[Buff]",
            treesitter = "[Trees]",
            path = "[Path]",
            nvim_lsp_signature_help = "[Signature]",
          })[entry.source.name]
          return vim_item
        end,
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'treesitter' },
        { name = 'buffer' },
        { name = 'path' },
        { name = 'vsnip' },
        { name = 'nvim_lsp_signature_help' },

    }, {}
    )
})

-- null-ls extras for autompletion
require'null-ls'.setup({
  debounce = 150,
  save_after_format = false,
  sources = { 
    -- formatting
    require'null-ls'.builtins.formatting.prettierd,
    require'null-ls'.builtins.formatting.shfmt,
    require'null-ls'.builtins.formatting.fixjson,
    -- diagnostics
    require'null-ls'.builtins.diagnostics.tsc,
    -- require'null-ls'.builtins.eslint_d,
    -- Code Actions
    -- require'null-ls'.builtins.code_actions.gitsign,
    -- require'null-ls'.builtins.gitrebase,
    -- hover 
    require'null-ls'.builtins.hover.dictionary,
  },
  root_dir = require'null-ls.utils'.root_pattern ".git",
})

-- REST.nvim 
-- require'rest-nvim'.setup({
--     highlight = {
--        enabled = true,
--        timeout = 150,
--    },
-- })

-- nvim_lsp.omnisharp.setup {}

-- require'lspsaga'.init_lsp_saga{
--   error_sign = '',
--   warn_sign = '',
--  hint_sign = '',
--   infor_sign = '',
--  border_style = "round",
--  dianostic_header_icon = '   ',
--  code_action_icon = ' ',
--  code_action_prompt = {
--    enable = true,
--    sign = true,
--    sign_priority = 20,
--    virtual_text = true,
--  },
--  finder_definition_icon = '  ',
--  finder_reference_icon = '  ',
--  }
---- Display functions signature
-- nvim_lsp.gopls.setup({ capabilities = capabilities })

--require'lsp_signature'.setup({
--    bind = true,
--    floating_window = true, --if false, use a hint
--    -- configure the hing
--    hint_enable = true,
--    hint_prefix = "🐼 ",
--    -- configure the floating window
--    handler_opts = {
--        border = "rounded"
--    },
--})

--require'treesitter-context'.setup{
--    enable = true,
--    throttle =  true,
--    max_lines = 0,
--    default = {
--        'class', 'function', 'method',
--        },
--    exact_patterns = {}
--    }
--
-- LSP-colors for diagnostics for themes without them
-- require("lsp-colors").setup({
--  Error = "#db4b4b",
--  Warning = "#e0af68",
--  Information = "#0db9d7",
--  Hint = "#10B981"
-- })

require("indent_blankline").setup {
    show_end_of_line = false,
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
}

require("which-key").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }


require'fzf-lua'.setup {
  file_ignore_patterns = {"%.py$", "%.git$", "node_modules", "packages", "build", "pub"},
  multiprocess=true,
  files = {
    prompt = "Files> ",
    git_icons = false,
-- improve a bit of speed
    file_icons = true,
-- but keep some icons
  }
}



-- Treesitter
vim.opt.foldmethod='expr'
vim.opt.completeopt = 'menuone,noinsert,noselect'

-- set foldmethod=expr 
-- set foldexpr=nvim_treesitter#foldexpr() 
-- set completeopt-=preview
-- use omni comletion from lsp
-- autocmd Filetype python setlocal omnifunc=v:lua.vim.lsp.omnifunc
-- KEYS {
vim.keymap.set( '', '<leader>e', vim.diagnostic.open_float)
-- nnoremap <silent><leader>e <cmd>lua vim.diagnostic.open_float()<CR>
-- Go To keys
local bufopts = { noremap=true, silent=true }
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
-- nnoremap <silent> gd <cmd>lua vim.lsp.buf.declaration()<CR>
-- nnoremap <silent> gD <cmd>lua vim.lsp.buf.definition()<CR>
-- nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
-- nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
-- Actions and menus
-- nnoremap <silent><leader>ca <cmd>lua vim.lsp.buf.code_action()<CR>
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
--" nnoremap <silent><leader>ca :Lspsaga code_action<CR>
--" vnoremap <silent><leader>ca :<C-U>Lspsaga range_code_action<CR>
--nnoremap <silent><leader>cc :Lspsaga show_line_diagnostics<CR>
--"Hints and doc
vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
vim.keymap.set('n', 'cs', vim.lsp.buf.signature_help, bufopts)
vim.keymap.set('n', 'cd', vim.lsp.buf.type_definition, bufopts)
-- nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
-- nnoremap <silent><C-k>  <cmd>lua vim.lsp.buf.signature_help()<CR>
-- nnoremap <silent> cs    <cmd>lua vim.lsp.buf.signature_help()<CR>
-- nnoremap <silent><leader>cs    <cmd>lua vim.lsp.buf.signature_help()<CR>
-- nnoremap <silent> cd <cmd>lua vim.lsp.buf.type_definition()<CR>
-- nnoremap <silent><leader>cd <cmd>lua vim.lsp.buf.type_definition()<CR>
--" nnoremap <silent>K :Lspsaga hover_doc<CR> 
--" nnoremap <silent>cs :Lspsaga signature_help<CR>
--" nnoremap <silent><leader>cs :Lspsaga signature_help<CR>
--" nnoremap <silent>cd :Lspsaga preview_definition<CR>
--" nnoremap <silent><leader>cd :Lspsaga preview_definition<CR>
--"find references and definition of method/variable under cursor
-- nnoremap <silent>ch <Cmd>Lspsaga lsp_finder<CR> 
-- nnoremap <silent><leader>ch <Cmd>Lspsaga lsp_finder<CR> 

--" Other functionality
--" rename
vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
vim.keymap.set('n', 'cr', vim.lsp.buf.rename, bufopts)
vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
--nnoremap <silent>cr <cmd>lua vim.lsp.buf.rename()<CR>'
--nnoremap <silent><leader>cr <cmd>lua vim.lsp.buf.rename()<CR>'
--" nnoremap <silent>cr :Lspsaga rename<CR>
--" nnoremap <silent><leader>cr :Lspsaga rename<CR>
--" scrolling inside popup
--nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
--nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>
--nnoremap <silent> [e :Lspsaga diagnostic_jump_next<CR>
--nnoremap <silent> ]e :Lspsaga diagnostic_jump_prev<CR>


--nnoremap <silent> <leader>E <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
--nnoremap <silent> <leader>q <cmd>lua vim.lsp.diagnostic.set_loclist()<CR>
--" nnoremap <space>ca <cmd>lua vim.lsp.buf.code_action()<CR>
--nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
--nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
--nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>


-- Telescope / Fuzzy finder 

vim.keymap.set('n', '<c-P>', "<cmd>lua require('fzf-lua').files()<CR>", { noremap = true, silent = true })

