return {
  {
    "serhez/teide.nvim",
    lazy = false,
    priority = 1000, -- only main colorscheme must declare it
    config = function()
      vim.cmd([[colorscheme teide-dimmed]])
    end,

  },
  {
    'sainnhe/sonokai',
    -- priority = 1000,
    -- config = function()
    --   vim.cmd([[colorscheme sonokai]])
    -- end,
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = true,         -- load on demand; switch with :colorscheme catppuccin-mocha
    opts = {
      flavour = 'mocha', -- latte | frappe | macchiato | mocha
      term_colors = true,
      dim_inactive = {
        enabled = true, -- dims inactive windows slightly
        shade = 'dark',
        percentage = 0.15,
      },
      styles = {
        comments  = { 'italic' },
        keywords  = { 'italic' },
        functions = {},
        variables = {},
        booleans  = { 'bold' },
      },
      integrations = {
        blink_cmp          = true,
        gitsigns           = true,
        mini               = { enabled = true, indentscope_color = 'overlay0' },
        native_lsp         = {
          enabled = true,
          virtual_text = {
            errors      = { 'italic' },
            hints       = { 'italic' },
            warnings    = { 'italic' },
            information = { 'italic' },
          },
          underlines = {
            errors      = { 'underline' },
            hints       = { 'underline' },
            warnings    = { 'underline' },
            information = { 'underline' },
          },
        },
        nvim_dap           = true,
        nvim_dap_ui        = true,
        treesitter         = true,
        treesitter_context = true,
        fzf                = true,
        render_markdown    = true,
        overseer           = true,
        aerial             = true,
        lsp_trouble        = true,
        dadbod_ui          = true,
        cmp                = false,

      },
    },
  },
  {
    'ribru17/bamboo.nvim',
  }

}
