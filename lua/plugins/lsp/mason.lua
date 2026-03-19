return {
  {
    'williamboman/mason.nvim',
    cmd = {
      'Mason',
      'MasonInstall',
      'MasonUpdate',
      'MasonUninstall',
      'MasonUninstallAll',
      'MasonLog',
    },
    opts = {},
  },
  {
    'neovim/nvim-lspconfig',
    lazy = true,
    event = { 'BufReadPre', 'BufNewFile' },
  },
  {
    'williamboman/mason-lspconfig.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'neovim/nvim-lspconfig',
      'saghen/blink.cmp', -- for enhanced capabilities if available
    },
    opts = {
      ensure_installed = {
        -- TypeScript / JavaScript
        'ts_ls', 'vtsls', 'eslint',
        -- Web
        'html', 'cssls', 'jsonls', 'yamlls',
        -- C# / .NET
        'csharp_ls',
        -- Go
        'gopls',
        -- Lua (for neovim config)
        'lua_ls',
        -- Vim
        'vimls',
        -- Bash / Shell
        'bashls',
      },
      automatic_installation = true,
    },
    config = function(_, opts)
      require('mason-lspconfig').setup(opts)
      require('lspconfig')

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
              telemetry = { enable = false },
              diagnostics = {
                globals = { 'vim', 'MiniFiles', 'MiniStatusline' },
              },
            },
          },
        },
        bashls = {
          settings = {
            bashIde = {
              -- shellcheck is the linter backend; mason installs it separately
              -- below via mason-tool-installer or manually via :MasonInstall shellcheck
              shellcheckPath = vim.fn.exepath('shellcheck') ~= '' and vim.fn.exepath('shellcheck') or '',
              -- shfmt for formatting (install via :MasonInstall shfmt)
              shfmt = {
                path = vim.fn.exepath('shfmt') ~= '' and vim.fn.exepath('shfmt') or '',
              },
              -- Glob patterns to treat as bash (not sh)
              globPattern = '**/*@(.sh|.inc|.bash|.command|.zsh)',
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
