return {
  { 'echasnovski/mini.files', 
    event = 'VeryLazy',
    opts={
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
    }, 
  },
}
