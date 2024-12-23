local status, codecompanion = pcall(require, 'codecompanion')
if (not status) then return end

codecompanion.setup({
  strategies = {
    chat = { adapter = "copilot" },
    inline = { adapter = "copilot" },
  },
  display = {
    action_palette = { provider = "mini_pick"},
    chat = {
      show_settings = true,
      render_headers = false,
    }
  }
})
