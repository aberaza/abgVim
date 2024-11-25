local status, codecompanion = pcall(require, 'codecompanion')
if (not status) then return end

codecompanion.setup({
  strategies = {
    chat = { adapter = "copilot" },
    inline = { adapter = "copilot" },
  },
  display = {
    chat = {
      show_settings = true,
      render_headers = false,
    }
  }
})
