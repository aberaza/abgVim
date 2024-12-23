local servers = { 'ts_ls', 'jsonls', 'html', 'vimls', 'csharp_ls' }

local signs = require('config.utils').icons.diagnostics
return {
  {
    'VonHeikemen/lsp-zero.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    cmd = 'Mason',
    dependencies = {
      { 'neovim/nvim-lspconfig' }, 
    },
    opts = {},
    config = function()
      local lsp = require('lsp-zero')
      lsp.extend_lspconfig({
        lsp_attach = function(client, bufnr)
          lsp.highlight_symbol(client, bufnr)
          lsp.default_keymaps({buffer = bufnr})
        end,--some function
      })
      lsp.ui({
        float_border = 'solid',
        sign_text = {
          error = signs.Error,
          warn = signs.Warning,
          hint = signs.Hint,
          info = signs.Information,
        },
      })
    end
  },
  {
    'neovim/nvim-lspconfig',
    lazy = true,
    -- 	--	event = 'LazyFile',
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "williamboman/mason-lspconfig.nvim" }, 
      { 'williamboman/mason.nvim' },
    },
    init = function()
      vim.opt.signcolumn = 'yes'
    end,
    -- opts = { },
      -- 		diagnostics = { underline = true, virtual_text = { spacing = 4, source = 'if_many',  prefix = "●"}, severity_sort = true },
      -- 		inlay_hints = { enabled = true },
      -- 		codelens = { enables = false },
      -- 		document_highlight = { enabled = true },
      -- 		servers = {
      -- 			lua_ls = { Lua = {
      -- 				codeLens = { enable = true }
      -- 			}}
      -- 		},
      -- setup = {
      --   ['*'] = function(server, opts)
      --     require('lspconfig')[server].setup(opts)
      --   end
      -- }
    -- },
    -- config =  function()
    --   local lsp_utils = require('plugins.lsp.utils')
    --   vim.api.nvim_create_autocmd('LspAttach', {
    --     desc = 'LSP action bindings attach',
    --     callback = lsp_utils.setup
    --   })
    --
    --   local lspconfig = require('lspconfig')
    --   for _, server in ipairs(servers) do
    --     lspconfig[server].setup {}
    --   end
    -- end
  },

  { 
    "williamboman/mason-lspconfig.nvim", 
    dependencies = { { 'williamboman/mason.nvim' } },
    opts = { 
      ensure_installed = servers,
      automatic_installation = false,
      handlers = {
        function(server_name)
          require('lspconfig')[server_name].setup({})
        end
      }
    } 
  },
  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    build = ':MasonUpdate',
    opts = {},
  }
}
-- ensure_installed = { "ts_ls", 'jsonls', 'html', 'vimls', 'csharp_ls' }
