local status, nvim_lsp = pcall(require, 'lspconfig')
if not status then return end
local util = require 'lspconfig.util'
-- Helpers
local function fixTSImports()
  typescript.actions.addMissingImports()
  typescript.actions.removeUnused()
  typescript.actions.organizeImports()
end

-- Keybindings
local keymap = vim.keymap

-- local wk_status, whichkey = pcall(require, 'which-key')
-- local function addKeymappings(client, bufnr)
--   print('Adding keybindings with whichkey for '..client.name)
--   -- Key mappings
--   keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
--   whichkey.register({
--     g = {
--       name = "LSP Goto",
--       d = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Definition" },
--       D = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Declaration" },
--       h = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature Help" },
--       i = { "<cmd>lua vim.lsp.buf.implementation<CR>", "Goto Implementation"},
--       I = { "<cmd>Telescope lsp_implementations<CR>", "Goto Implementation(TC)" },
--       b = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Goto Type Definition" },
--       td = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Goto Type Definition" },
--     },
--     c = {
--       name = "LSP Code",
--       r = { "<cmd>lua vim.lsp.buf.rename<CR>", "Rename Buf"},
--       K = { "<cmd>lua vim.lsp.buf.hover<CR>", "Hover"},
--       k = { "<cmd>lua vim.lsp.signature_help<CR>", "Signature"},
--       h = { "<cmd>lua vim.lsp.signature_help<CR>", "Signature"},
--       a = { "<cmd>lua vim.lsp.buf.code_action<CR>", "Code Actions"},
--     },
--     "<leader>" = {
--       l = {
--         name="LSP Servers",
--         R = { "<cmd>Trouble lsp_references<cr>", "Trouble References" },
--         a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
--         d = { "<cmd>Telescope diagnostics<CR>", "Diagnostics" },
--         f = { "<cmd>Lspsaga lsp_finder<CR>", "Finder" },
--         i = { "<cmd>LspInfo<CR>", "Lsp Info" },
--         n = { "<cmd>lua require('renamer').rename()<CR>", "Rename" },
--         r = { "<cmd>Telescope lsp_references<CR>", "References" },
--         s = { "<cmd>Telescope lsp_document_symbols<CR>", "Document Symbols" },
--         t = { "<cmd>TroubleToggle document_diagnostics<CR>", "Trouble" },
--         L = { "<cmd>lua vim.lsp.codelens.refresh()<CR>", "Refresh CodeLens" },
--         l = { "<cmd>lua vim.lsp.codelens.run()<CR>", "Run CodeLens" },
--         D = { "<cmd>lua require('config.lsp').toggle_diagnostics()<CR>", "Toggle Inline Diagnostics" },
--       },
--     },
--   })

  -- local keymap_visual = {
  --   '<leader>' = {
  --     l = {
  --       name="LSP Servers",
  --       a = { "<cmd>'<,'>lua vim.lsp.buf.range_code_action()<CR>", "Code Action" },
  --     }
  --   }
  -- }

  -- whichkey.register(keymap, { buffer = bufnr, mode="n"})
  -- whichkey.register(keymap_visual, { buffer = bufnr, mode="v"})
-- end

local function on_attach(client, bufnr)
  -- keymappings(client, bufnr)
  -- keymaps for the buffer
  local bufopts = { noremap=true, silent=true }
  -- Go To keys
  keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  keymap.set('n', 'gtd', vim.lsp.buf.type_definition, bufopts)
  -- Actions / Menus
  keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  keymap.set('n', 'gca', vim.lsp.buf.code_action, bufopts)
  -- Hints and doc
  keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  keymap.set('n', '<C-h>', vim.lsp.buf.hover, bufopts) -- help on mouseover
  keymap.set('n', 'gs', vim.lsp.buf.signature_help, bufopts)
  -- Refactor
  keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  keymap.set('n', 'cr', vim.lsp.buf.rename, bufopts)
  keymap.set('n', '<space>cf', function() vim.lsp.buf.format { async = true } end, bufopts)
  -- Only Typescript
  if client.name == 'tsserver' then
    keymap.set('n', '<leader>rf', ':TypescriptRenameFile<CR>', bufopts)
    keymap.set('n', '<leader>ri', fixTSImports, bufopts)
    keymap.set('n', '<leader>cf', typescript.actions.fixAll, bufopts)
  end
  -- vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  -- Use LSP as the handler for formatexpr. See `:help formatexpr` for more information.
  vim.api.nvim_buf_set_option(0, "formatexpr", "v:lua.vim.lsp.formatexpr()")
end



-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = true
-- capabilities.textDocument.completion.completionItem.resolveSupport = {
--     properties = { "documentation", "detail", "additionalTextEdits" },
-- }
-- else
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
-- end

-- Configure Servers
-- ###########################################################
local servers = { 'tsserver', 'jsonls', 'html', 'elmls', 'gopls', 'vimls' }

for _, lsp in pairs(servers) do
    nvim_lsp[lsp].setup ({
        capabilities = capabilities,
        on_attach = on_attach,
    })
end

-- Per Sever specific config
-- omnisharp
-- nvim_lsp.omnisharp.setup {
--   cmd = { "dotnet", "~/bin/omnisharp/OmniSharp.dll" },
--   enable_editorconfig_support = true,
--   enable_roslyn_analyzers = true,
--   enable_import_completion = true,
--   capabilities = capabilities,
--   on_attach = on_attach
-- }

nvim_lsp.csharp_ls.setup({
  root_dir = function(fname)
    return util.root_pattern '*.sln'(fname) or util.root_pattern '*.csproj'(fname)
  end,
  debounce_text_changes = 300, -- Wait 300ms before sending didChange
  capabilities = capabilities,
  on_attach = on_attach,
})
-- typescript 
local ts_status, typescript = pcall(require, 'typescript')
if ts_status then
  typescript.setup({
    go_to_source_definition = {
      fallback = true,
    },
    server = {
      capabilities = capabilities,
      on_attach = on_attach,
    }
})
end


-- use bun 
-- based on https://alpha2phi.medium.com/modern-neovim-configuration-recipes-d68b16537698
local bun_servers = { "tsserver", "volar", "tailwindcss", "eslint" }

local function is_bun_server(name)
  for _, server in ipairs(bun_servers) do
    if server == name then
      return true
    end
  end
  return false
end

local function is_bun_available()
  local bunx = vim.fn.executable "bunx"
  if bunx == 0 then
    return false
  end
  return true
end

local function add_bun_prefix(config, _)
  if config.cmd and is_bun_available() and is_bun_server(config.name) then
    print('Attached to ' .. client.name .. ' using bunx')
    config.cmd = vim.list_extend({
      "bunx",
    }, config.cmd)
  end
end

nvim_lsp.util.on_setup = nvim_lsp.util.add_hook_before(nvim_lsp.util.on_setup, add_bun_prefix)
