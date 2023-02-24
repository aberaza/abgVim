
-- Basic LSP config
-- local nvim_lsp = require('lspconfig')
-- -- local lsp_defaults = nvim_lsp.util.default_config
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = true
-- capabilities.textDocument.completion.completionItem.resolveSupport = {
--   properties = { "documentation", "detail", "additionalTextEdits" },
-- }
-- capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- local signs = { Error = "", Warn = "", Hint = "", Info = "" }
-- -- local signs = { Error = "✘", Warn = "▲", Hint = "⚑", Info = "" }
-- for type, icon in pairs(signs) do
--     local hl = "DiagnosticSign" .. type
--     vim.fn.sign_define(hl, { text = icon, texthl= hl, numhl = hl })
-- end

-- local function on_attach(client, bufnr)
--   print('Attached to ' .. client.name)
--   -- Enable completion triggered by <C-X><C-O>
--   -- See `:help omnifunc` and `:help ins-completion` for more information.
--   vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
--   -- Use LSP as the handler for formatexpr.
--   -- See `:help formatexpr` for more information.
--   vim.api.nvim_buf_set_option(0, "formatexpr", "v:lua.vim.lsp.formatexpr()")
--   -- Configure key mappings
--   -- require("config.lsp.keymaps").setup(client, bufnr)
-- end

-- local servers = { 'tsserver', 'jsonls', 'html', 'elmls', 'gopls', 'vimls' }

-- for _, lsp in pairs(servers) do
--     nvim_lsp[lsp].setup ({
--         capabilities = capabilities,
--         on_attach = on_attach,
--         flags = {
--             -- default in neovim 0.7+
--             debounce_text_changes = 150,
--         },
--     })
-- end

-- local util = require('lspconfig').util
-- nvim_lsp.csharp_ls.setup {
--   filetypes = { 'cs', 'csx', 'vb' },
--   root_dir = function(file, _)
--     if file:sub(-#".csx") == ".csx" then
--       return util.path.dirname(file)
--     end
--     -- return util.root_pattern("*.sln")(file) or util.root_pattern("*.csproj")(file)
--     return util.root_pattern("*.sln")(file)
-- end,
-- }

-- nvim_lsp.omnisharp.setup {
--   cmd = { "dotnet", "~/.local/opt/omnisharp-net6.0/OmniSharp.dll" },
--   enable_editorconfig_support = true,
--   enable_import_completion = false, -- can negatively impact performance
--   sdk_include_prereleases = true,
-- }


require('glow').setup()

require("which-key").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
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
-- vim.keymap.set( '', '<leader>e', vim.diagnostic.open_float)
-- nnoremap <silent><leader>e <cmd>lua vim.diagnostic.open_float()<CR>
-- Go To keys
-- local bufopts = { noremap=true, silent=true }
-- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
-- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
-- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
-- vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
-- vim.keymap.set('n', 'gtd', vim.lsp.buf.type_definition, bufopts)
-- nnoremap <silent> gd <cmd>lua vim.lsp.buf.declaration()<CR>
-- nnoremap <silent> gD <cmd>lua vim.lsp.buf.definition()<CR>
-- nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
-- nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
-- Actions and menus
-- nnoremap <silent><leader>ca <cmd>lua vim.lsp.buf.code_action()<CR>
-- vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
--" nnoremap <silent><leader>ca :Lspsaga code_action<CR>
--" vnoremap <silent><leader>ca :<C-U>Lspsaga range_code_action<CR>
--nnoremap <silent><leader>cc :Lspsaga show_line_diagnostics<CR>
--"Hints and doc
-- vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
-- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
-- vim.keymap.set('n', '<C-h>', vim.lsp.buf.hover, bufopts) -- help on mouseover
-- vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, bufopts)
-- vim.keymap.set('n', 'gca', vim.lsp.buf.code_action, bufopts)
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
-- vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
-- vim.keymap.set('n', 'cr', vim.lsp.buf.rename, bufopts)
-- vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
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
