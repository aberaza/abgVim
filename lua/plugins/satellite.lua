return {
  {
    'lewis6991/satellite.nvim',
    version = false,
    -- Only load when there's actually a buffer to decorate
    event = 'BufReadPost',
    keys = {
      {
      '<leader>uS',
        function()
          -- satellite has no public toggle API; we toggle the enabled option
          -- and reload the plugin to apply it.
          local ok, satellite = pcall(require, 'satellite')
          if not ok then return end
          if vim.g.satellite_disabled then
            vim.g.satellite_disabled = false
            satellite.enable()
            vim.notify('Satellite scrollbar: ON', vim.log.levels.INFO)
          else
            vim.g.satellite_disabled = true
            satellite.disable()
            vim.notify('Satellite scrollbar: OFF', vim.log.levels.INFO)
          end
        end,
        desc = 'Toggle Satellite Scrollbar',
      },
    },
    opts = {
      -- Show the satellite bar only in normal buffers (not on special windows)
      current_only = false,
      winblend = 50,    -- slight transparency to keep it subtle
      zindex = 40,

      -- Which handlers to display on the scrollbar
      handlers = {
        -- Cursor position (the bar thumb itself)
        cursor = {
          enable = true,
          symbols = { '▎' },  -- thin vertical line, fits the minimalist theme
        },
        -- LSP diagnostics  — coloured dots on the bar edge
        diagnostic = {
          enable = true,
          signs = {
            [vim.diagnostic.severity.ERROR] = '●',
            [vim.diagnostic.severity.WARN]  = '●',
            [vim.diagnostic.severity.INFO]  = '●',
            [vim.diagnostic.severity.HINT]  = '●',
          },
          min_severity = vim.diagnostic.severity.HINT,
        },
        -- Git hunks (gitsigns integration)
        gitsigns = {
          enable = true,
          signs = {
            add    = '▎',
            change = '▎',
            delete = '▎',
          },
        },
        -- Search matches
        search = {
          enable = true,
        },
        -- Mark positions
        marks = {
          enable = true,
          show_builtins = false,  -- hide 0-9 builtin marks; only show user marks
        },
        -- Quickfix / location list entries
        quickfix = {
          signs = { '-', '=', '≡' },
        },
      },
    },
  },
}
