local status, nvim_lsp = pcall(require, 'lspconfig')
if not status then return end

-- local csharp_status, csharp = pcall(require, 'csharp_ls')
local ts_status, typescript = pcall(require, 'typescript')
-- local typescript = require('typescript')
-- local cmp_status, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')

-- Keybindings
local keymap = vim.keymap
local function fixTSImports()
  typescript.actions.addMissingImports()
  typescript.actions.removeUnused()
  typescript.actions.organizeImports()
end
local function on_attach(client, bufnr)
  print('Attached to ' .. client.name)
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



local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = { "documentation", "detail", "additionalTextEdits" },
  }
-- else
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
-- end

-- Configure Servers
-- basic config servers

local servers = { 'tsserver', 'jsonls', 'html', 'elmls', 'gopls', 'vimls' }

for _, lsp in pairs(servers) do
    nvim_lsp[lsp].setup ({
        capabilities = capabilities,
        on_attach = on_attach,
    })
end
-- csharp lsp
nvim_lsp.csharp_ls.setup {
  filetypes = { 'cs', 'csx', 'vb' },
  root_dir = function(file, _)
    if file:sub(-#".csx") == ".csx" then
      return nvim_lsp.util.path.dirname(file)
    end
    -- return util.root_pattern("*.sln")(file) or util.root_pattern("*.csproj")(file)
    return nvim_lsp.util.root_pattern("*.sln")(file)
end,
}

-- typescript 
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
