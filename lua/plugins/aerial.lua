return {
  { 'stevearc/aerial.nvim',
    lazy = true,
    cmd = { 'Aerial', 'AerialToggle', 'AerialOpen', 'AerialClose' },
    opts = {
      placement = edge
    },
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
  }
}
