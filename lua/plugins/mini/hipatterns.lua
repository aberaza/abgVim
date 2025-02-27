return {
  { 'nvim-mini/mini.hipatterns', 
    opts = {
      highlighters = {
        fixme       = { pattern = "%f[%w]()FIXME()%f[%W]",   group = "MiniHipatternsFixme" },
        hack        = { pattern = "%f[%w]()HACK()%f[%W]",    group = "MiniHipatternsHack" },
        todo        = { pattern = "%f[%w]()TODO()%f[%W]",    group = "MiniHipatternsTodo" },
        note        = { pattern = "%f[%w]()NOTE()%f[%W]",    group = "MiniHipatternsNote" },
        jira        = { pattern = "%f[%w]()JIRA()%f[%W]",    group = "MiniHipatternsNote" },
      }
    },
    config = function(_, opts)
      local hi_patterns = require('mini.hipatterns')
      hi_patterns.setup( 
        vim.tbl_deep_extend("force", opts, {
          highlighters = {
            hex_color = hi_patterns.gen_highlighter.hex_color({ style = "inline", inline_text = "⬤ " }),
          }
        })
      )
    end
  }
}
