return {
  {
    'neovim/nvim-lspconfig',
    lazy = true,
    event = { 'BufReadPre', 'BufNewFile' },
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
      { 'williamboman/mason.nvim', opts = {} },
      'neovim/nvim-lspconfig',
    },
    opts = {
      ensure_installed = {
        -- TypeScript / JavaScript
        'ts_ls',
        'vtsls',
        'eslint',
        -- Web
        'html',
        'cssls',
        'jsonls',
        'yamlls',
        -- C# / .NET
        'omnisharp',
        -- Go
        'gopls',
        -- Lua (for neovim config)
        'lua_ls',
        -- Vim
        'vimls',
      },
      automatic_installation = true,
    },
    config = function(_, opts)
      require('mason-lspconfig').setup(opts)

      local capabilities = vim.lsp.protocol.make_client_capabilities()

      -- Try to extend capabilities with blink.cmp if available
      local ok_blink, blink = pcall(require, 'blink.cmp')
      if ok_blink then
        capabilities = blink.get_lsp_capabilities(capabilities)
      end

      -- Server-specific settings
      local server_settings = {
        lua_ls = {
          settings = {
            Lua = {
              workspace = { checkThirdParty = false },
              telemetry = { enable = false },
              diagnostics = {
                globals = { 'vim', 'MiniFiles', 'MiniStatusline' },
              },
            },
          },
        },
        gopls = {
          settings = {
            gopls = {
              analyses = {
                unusedparams = true,
                shadow = true,
              },
              staticcheck = true,
              gofumpt = true,
            },
          },
        },
        omnisharp = {
          settings = {
            omnisharp = {
              enableRoslynAnalyzers = true,
              organizeImportsOnFormat = true,
              enableEditorConfigSupport = true,
            },
          },
        },
        eslint = {
          on_attach = function(_, bufnr)
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = bufnr,
              command = 'EslintFixAll',
            })
          end,
        },
        ts_ls = {
          settings = {
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = 'all',
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
              },
            },
            javascript = {
              inlayHints = {
                includeInlayParameterNameHints = 'all',
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
              },
            },
          },
        },
      }

      -- Auto-setup all installed servers
      local installed = require('mason-lspconfig').get_installed_servers()
      for _, server_name in ipairs(installed) do
        local server_opts = vim.tbl_deep_extend('force', {}, server_settings[server_name] or {})
        server_opts.capabilities = capabilities
        vim.lsp.config(server_name, server_opts)
        vim.lsp.enable(server_name)
      end
    end,
  },
}
