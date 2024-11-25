local status, nvim_lsp = pcall(require, 'lspconfig')
if not status then return end

local servers = { 'ts_ls', 'jsonls', 'html', 'vimls', 'csharp_ls' }
-- local install = { 'ts_ls', 'jsonls', 'hmtl', 'vimls', 'csharp_ls'}

require("mason").setup()
require("mason-lspconfig").setup {
  ensure_installed = servers,
  automatic_installation = false,
}

local util = require 'lspconfig.util'
-- Helpers
-- local function fixTSImports()
--   typescript.actions.addMissingImports()
--   typescript.actions.removeUnused()
--   typescript.actions.organizeImports()
-- end

-- Keybindings

local augroup   =   
vim.api.nvim_create_augroup("LspAttachGroup", { clear = true })

vim.api.nvim_create_autocmd('LspAttach', {
  group = augroup,
  desc = "Register Keybindings on LSP Attach",
  callback = function(args)
    local keymap = vim.keymap
    local function desc(description)
      return { noremap=true, silent=true, desc=description, buffer=args.buf }
    end
    -- Go To keys
    keymap.set('n', 'gD', vim.lsp.buf.declaration, desc('Goto Declaration'))
    keymap.set('n', 'gd', vim.lsp.buf.definition, desc('Goto definition'))
    keymap.set('n', 'gi', vim.lsp.buf.implementation, desc('Goto implementation'))
    keymap.set('n', 'gr', vim.lsp.buf.references, desc('Goto references'))
    keymap.set('n', 'gtd', vim.lsp.buf.type_definition, desc('Goto type definition'))
    keymap.set('n', 'go', vim.lsp.buf.type_definition, desc('Goto type definition'))
    -- Actions / Menus
    keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, desc('Code Actions'))
    keymap.set('n', 'gca', vim.lsp.buf.code_action, desc('Code Actions'))
    -- Hints and doc
    keymap.set('n', 'K', vim.lsp.buf.hover, desc('Hover'))
    keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, desc('Signature Help'))
    keymap.set('n', '<C-h>', vim.lsp.buf.hover, desc('Hover')) -- help on mouseover
    keymap.set('n', 'gs', vim.lsp.buf.signature_help, desc('Signature Help'))
    -- Refactor
    keymap.set('n', '<space>rn', vim.lsp.buf.rename, desc('Rename Symbol'))
    keymap.set('n', 'cr', vim.lsp.buf.rename, desc('Rename Symbol'))
    keymap.set('n', '<space>cf', function() vim.lsp.buf.format { async = true } end, desc('Format Buffer'))
    -- Only Typescript
    local clientName = vim.lsp.get_client_by_id(args.data.client_id).name
    -- if (clientName == 'tsserver' or clientName == 'ts_ls') then
    --   local typescript = require('typescript')
    --   keymap.set('n', '<leader>rf', ':TypescriptRenameFile<CR>', desc('TS Rename Buffer'))
    --   keymap.set('n', '<leader>ci', fixTSImports, desc('TS Fix Imports'))
    --   keymap.set('n', '<leader>cf', typescript.actions.fixAll, desc('TS Fix All'))
    -- end
    -- Use LSP as the handler for formatexpr. See `:help formatexpr` for more information.
    vim.api.nvim_buf_set_option(0, "formatexpr", "v:lua.vim.lsp.formatexpr()")
  end
})

local status, cmp = pcall(require, 'cmp_nvim_lsp')
if status then
  capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

  for _, lsp in pairs(servers) do
    -- print("Configuring LSP server: " .. lsp)
    if nvim_lsp[lsp] then
      nvim_lsp[lsp].setup ({
        capabilities = capabilities,
      })
    else
      print("LSP server not found: " .. lsp)
    end

  end
end

-- C# .Net
nvim_lsp.csharp_ls.setup({
  debounce_text_changes = 300, -- Wait 300ms before sending didChange
})

-- -- use bun 
-- -- based on https://alpha2phi.medium.com/modern-neovim-configuration-recipes-d68b16537698
-- local bun_servers = { "tsserver", "volar", "tailwindcss", "eslint" }
--
-- local function is_bun_server(name)
--   for _, server in ipairs(bun_servers) do
--     if server == name then
--       return true
--     end
--   end
--   return false
-- end
--
-- local function is_bun_available()
--   local bunx = vim.fn.executable "bunx"
--   if bunx == 0 then
--     return false
--   end
--   return true
-- end
--
-- local function add_bun_prefix(config, _)
--   if config.cmd and is_bun_available() and is_bun_server(config.name) then
--     print('Attached to ' .. client.name .. ' using bunx')
--     config.cmd = vim.list_extend({
--       "bunx",
--     }, config.cmd)
--   end
-- end
--
-- nvim_lsp.util.on_setup = nvim_lsp.util.add_hook_before(nvim_lsp.util.on_setup, add_bun_prefix)
