return {
  { 'echasnovski/mini.diff', 
    event = 'VeryLazy',
    keys = {
      { '<leader>go', function() require('mini.diff').toggle_overlay(0) end, desc = 'Toggle Diff Overlay' },
    },
    opts = {
      view = {
        style = 'sign', -- 'sign' | 'line' | 'word'
        signs = {
          add = '▎',
          change= "▎",
          delete = "",
        } 
      }
    } 
  },
}
