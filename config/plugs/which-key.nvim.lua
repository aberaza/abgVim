local status, whichkey = pcall(require, 'which-key')
if (not status) then return end

whichkey.setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    plugins = {
      marks = true, -- list of marks on ' and `
      registers = true, -- list of registers on <C-r>
      presets = {
        operators = true,
        motions = true,
        text_objects = true,
        windows = true, 
        nav = true,
        z = true,
        g = true,
      },
    }, 
}

whichkey.register({
  t = {
    name = "toggle",
    f = "Fugitive",
    b = "Git Blame",
    g = "Git Signify",
  },
  v = {
    name = "neovim",
    r = "Reload config",
    c = "Open neovim config",
  }
}, { prefix = "<leader>" })
