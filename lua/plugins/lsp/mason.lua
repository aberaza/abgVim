local diagnostic_icons = require('config.utils').diagnostics

return {
  {
    'neovim/nvim-lspconfig',
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
  },
  { 
    "williamboman/mason-lspconfig.nvim", 
    dependencies = { 
      { 'williamboman/mason.nvim', opts = {} }, 
      'neovim/nvim-lspconfig' 
    },
    opts = { 
      ensure_installed = { 
        'ts_ls', 
        'jsonls', 
        'html', 
        'vimls', 
        'csharp_ls', 
        'yamlls',
        'gopls',
      },
      automatic_installation = true,
    } 
  }
}
