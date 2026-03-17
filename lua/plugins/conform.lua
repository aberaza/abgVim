return {
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo', 'Format' },
    keys = {
      {
        '<leader>cf',
        function() require('conform').format({ async = true, lsp_fallback = true }) end,
        mode = { 'n', 'v' },
        desc = 'Format Buffer / Selection',
      },
    },
    opts = {
      -- Map filetypes to formatter lists.
      -- Formatters run in order; the first available one wins unless
      -- { stop_after_first = false } is set on the list entry.
      formatters_by_ft = {
        -- Web
        javascript      = { 'prettier' },
        javascriptreact = { 'prettier' },
        typescript      = { 'prettier' },
        typescriptreact = { 'prettier' },
        css             = { 'prettier' },
        html            = { 'prettier' },
        json            = { 'prettier' },
        jsonc           = { 'prettier' },
        yaml            = { 'prettier' },
        markdown        = { 'prettier' },
        -- C# / .NET  (install: dotnet tool install -g csharpier)
        cs              = { 'csharpier' },
        -- Go  (gofumpt is stricter than gofmt; installed via mason/system)
        go              = { 'gofumpt', 'goimports' },
        -- Shell  (shfmt installed via mason)
        sh              = { 'shfmt' },
        bash            = { 'shfmt' },
        zsh             = { 'shfmt' },
        -- Lua  (stylua installed via mason)
        lua             = { 'stylua' },
        -- SQL  (sqlfmt or sql-formatter; prefer whichever is installed)
        sql             = { 'sql_formatter' },
        -- Fallback for anything that has an LSP formatter only
        ['*']           = {},
      },

      -- Format on save — async to avoid blocking the write
      format_on_save = function(bufnr)
        -- Disable for files larger than 1 MB
        local stat = vim.uv.fs_stat(vim.api.nvim_buf_get_name(bufnr))
        if stat and stat.size > 1024 * 1024 then return end
        -- Respect a buffer-local opt-out: vim.b.disable_autoformat = true
        if vim.b[bufnr].disable_autoformat or vim.g.disable_autoformat then
          return
        end
        return { timeout_ms = 1500, lsp_fallback = true }
      end,

      -- Per-formatter tweaks
      formatters = {
        shfmt = {
          -- -i 2: 2-space indent  -ci: indent case labels  -bn: binary ops on new line
          prepend_args = { '-i', '2', '-ci', '-bn' },
        },
        prettier = {
          -- Respect project-local .prettierrc / .prettierignore if present
          require_cwd_file = { '.prettierrc', '.prettierrc.js', '.prettierrc.json',
                               '.prettierrc.yaml', '.prettierrc.yml', 'prettier.config.js' },
        },
        stylua = {
          require_cwd_file = { 'stylua.toml', '.stylua.toml' },
        },
      },
    },

    config = function(_, opts)
      local conform = require('conform')
      conform.setup(opts)

      -- :Format command with optional range (works in visual mode too)
      vim.api.nvim_create_user_command('Format', function(args)
        local range = nil
        if args.count ~= -1 then
          local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
          range = {
            start = { args.line1, 0 },
            ['end'] = { args.line2, end_line:len() },
          }
        end
        conform.format({ async = true, lsp_fallback = true, range = range })
      end, { range = true })

      -- Toggle auto-format on save for current buffer
      vim.keymap.set('n', '<leader>uf', function()
        vim.b.disable_autoformat = not vim.b.disable_autoformat
        vim.notify(
          'Auto-format on save: ' .. (vim.b.disable_autoformat and 'OFF' or 'ON'),
          vim.log.levels.INFO
        )
      end, { desc = 'Toggle Auto-format on Save' })

      -- Toggle auto-format globally
      vim.keymap.set('n', '<leader>uF', function()
        vim.g.disable_autoformat = not vim.g.disable_autoformat
        vim.notify(
          'Global auto-format on save: ' .. (vim.g.disable_autoformat and 'OFF' or 'ON'),
          vim.log.levels.INFO
        )
      end, { desc = 'Toggle Global Auto-format on Save' })
    end,
  },
}
