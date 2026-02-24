return { 'saghen/blink.cmp',
  enabled = true,
  dependencies = {
    'rafamadriz/friendly-snippets',
    'fang2hou/blink-copilot',
  },
  -- use a release tag to download pre-built binaries
  version = '1.*',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
    -- 'super-tab' for mappings similar to vscode (tab to accept)
    -- 'enter' for enter to accept
    -- 'none' for no mappings
    --
    -- All presets have the following mappings:
    -- C-space: Open menu or open docs if already open
    -- C-n/C-p or Up/Down: Select next/previous item
    -- C-e: Hide menu
    -- C-k: Toggle signature help (if signature.enabled = true)
    --
    -- See :h blink-cmp-config-keymap for defining your own keymap
    keymap = { preset = 'super-tab' },

    appearance = {
      nerd_font_variant = 'mono',
    },

    completion = {
      documentation = { auto_show = true, auto_show_delay_ms = 250 },
      menu = { auto_show = true },
      ghost_text = { enabled = false }, -- disabled in favor of copilot inline suggestions
    },

    signature = { enabled = true },

    sources = {
      per_filetype = {
        codecompanion = { 'codecompanion' },
        sql = { 'dadbod', 'buffer' },
      },
      default = { 'copilot', 'codecompanion', 'lsp', 'path', 'snippets', 'buffer' },
      providers = {
        dadbod = { module = 'vim_dadbod_completion.blink', name = 'Dadbod' },
        copilot = { name = 'Copilot', module = 'blink-copilot', score_offset = 100, async = true },
      },
    },

    fuzzy = {
      sorts = { 'exact', 'score', 'sort_text' },
      implementation = 'prefer_rust_with_warning',
    },
  },
  opts_extend = { 'sources.default' },
}

