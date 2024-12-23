return {
  { 'echasnovski/mini.hipatterns', 
    opts = {
      highlighters = {
      --   hex_color = require('mini.hipatterns').gen_highlighter.hex_color({
      --     style = "inline",
      --     inline_text = "⬤ ",
      --   }),
        fixme       = { pattern = "%f[%w]()FIXME()%f[%W]",   group = "MiniHipatternsFixme" },
        hack        = { pattern = "()HACK():",    group = "MiniHipatternsHack" },
        todo        = { pattern = "()TODO():",    group = "MiniHipatternsTodo" },
        note        = { pattern = "%f[%w]()NOTE()%f[%W]",    group = "MiniHipatternsNote" },
        jira        = { pattern = "%f[%w]()JIRA()%f[%W]",    group = "MiniHipatternsNote" },
      }
    },
    setup = function()
      local hi_patterns = require('mini.hipatterns')
      hi_patterns.setup({
        highlighters = {
          hex_color = hi_patterns.gen_highlighter.hex_color({
            style = "inline",
            inline_text = "⬤ ",
          }),
        }
      })
    end
  }
}
