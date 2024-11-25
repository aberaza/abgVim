local status, md = pcall(require, 'render-markdown')
if (not status) then return end

md.setup({
  file_types = { "markdown", "codecompanion"},
  render_modes = { 'n', 'c'},
})
