return {
  { 'echasnovski/mini.clue',
    event = 'VeryLazy',
    opts = {
      triggers = {
        -- leader triggers
        { mode = 'n', keys = '<leader>' },
        { mode = 'x', keys = '<leader>' },
        -- builtin completion
        { mode = 'i', keys = '<C-x>' },
        -- g (goto) commands
        { mode = 'n', keys = 'g' },
        { mode = 'x', keys = 'g' },
        -- Marks commands
        { mode = 'n', keys = "'" },
        { mode = 'n', keys = '`' },
        { mode = 'x', keys = "'" },
        { mode = 'x', keys = '`' },
        -- Registers copmletion
        { mode = 'n', keys = '"' },
        { mode = 'x', keys = '"' },
        { mode = 'i', keys = '<C-r>' },
        { mode = 'c', keys = '<C-r>' },
        -- Window navigation
        { mode = 'n', keys = '<C-w>' },
        { mode = 'x', keys = '<C-w>' },
        -- Foldings commands
        { mode = 'n', keys = 'z' },
        { mode = 'x', keys = 'z' },
      },
      window = {
        delay = 100,
        row = 'auto',
        col = 'auto',
        anchor = 'NW', -- North-West corner
      },
    },
    config = function(_, opts)
      local miniclue = require('mini.clue')
      miniclue.setup( vim.tbl_deep_extend("force", {
          clues = {
            miniclue.gen_clues.builtin_completion(),
            miniclue.gen_clues.g(),
            miniclue.gen_clues.marks(),
            miniclue.gen_clues.registers(),
            miniclue.gen_clues.windows(),
            miniclue.gen_clues.z(),
          }
        }, opts)
      )
    end,
  },
}
