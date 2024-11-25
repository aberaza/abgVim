local status, files = pcall(require, 'mini.files')
if (not status) then return end

files.setup({
  mappings = {
    go_in_plus = '<CR>'
  },
  options = {
    use_as_default_explorer = true, -- if true, will replace netrw
  },
  windows = {
    preview = true,
    width_preview = 60,
    width_focus = 35,
    width_nonfocus = 15,
  }
})

