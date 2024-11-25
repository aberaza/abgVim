local status, hipatterns = pcall(require, 'mini.hipatterns')
if (not status) then return end

--Highlight some words
hipatterns.setup({
  highlighters = {
    hex_color = hipatterns.gen_highlighter.hex_color({
        style = "inline",
        inline_text = "⬤  ",
      }),
    fixme       = { pattern = "%f[%w]()FIXME()%f[%W]",   group = "MiniHipatternsFixme" },
    hack        = { pattern = "()HACK():",    group = "MiniHipatternsHack" },
    todo        = { pattern = "()TODO():",    group = "MiniHipatternsTodo" },
    note        = { pattern = "%f[%w]()NOTE()%f[%W]",    group = "MiniHipatternsNote" },
    jira        = { pattern = "%f[%w]()JIRA()%f[%W]",    group = "MiniHipatternsNote" },
  }
})
