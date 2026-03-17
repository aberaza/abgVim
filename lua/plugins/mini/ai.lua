return {
  {
    'echasnovski/mini.ai',
    version = false,
    -- Load on the first keypress that could be a text-object (operator-pending
    -- or visual mode) rather than at startup.
    event = 'VeryLazy',
    dependencies = {
      'echasnovski/mini.extra',             -- provides gen_ai_spec.line / indent
      'nvim-treesitter/nvim-treesitter',    -- needed for gen_spec.treesitter()
      -- nvim-treesitter-textobjects ships the @function.*, @class.* etc. queries
      -- that gen_spec.treesitter() reads via vim.treesitter.query.get().
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    opts = function()
      local ai      = require('mini.ai')
      local extra   = require('mini.extra')
      local ts      = ai.gen_spec.treesitter

      return {
        -- How far (in lines) to search for a textobject from the cursor.
        n_lines = 500,

        -- 'cover_or_next': prefer covering the cursor position, fall back to
        -- the next match on the same line, then in the n_lines neighbourhood.
        search_method = 'cover_or_next',

        custom_textobjects = {
          -- ── Treesitter-backed structural objects ──────────────────────────
          -- Capital F = function *definition* (vs. lowercase f = function call)
          F = ts({ a = '@function.outer', i = '@function.inner' }),

          -- Capital C = class / struct / interface definition
          C = ts({ a = '@class.outer',    i = '@class.inner' }),

          -- o = conditional OR loop block (combined alias — picks best match)
          o = ts({
            a = { '@conditional.outer', '@loop.outer' },
            i = { '@conditional.inner', '@loop.inner' },
          }),

          -- ── mini.extra textobjects ────────────────────────────────────────
          -- L = whole Line (linewise visual, works great with operators too)
          L = extra.gen_ai_spec.line(),

          -- I = Indent block (useful in Python/YAML/Bash; nice in any lang)
          I = extra.gen_ai_spec.indent(),

          -- ── Custom pattern-based objects ──────────────────────────────────
          -- Number literal (integer or float)
          n = { '%f[%d]%d+%.?%d*', '^().*()$' },

          -- camelCase / PascalCase word segment
          W = {
            {
              '%u[%l%d]+%f[^%l%d]',
              '%f[%S][%l%d]+%f[^%l%d]',
              '%f[%P][%l%d]+%f[^%l%d]',
              '^[%l%d]+%f[^%l%d]',
            },
            '^().*()$',
          },
        },
      }
    end,
  },
}
