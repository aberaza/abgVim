local status, ms = pcall(require, 'material')

vim.g.material_style = "darker"

ms.setup {
  contrast = {
    sidebars = true, 
    floating_windows = true,
    popup_menu = true,
  },
  italics = {
    comments = true,
    keywords = false,
    functions = false,
    variables = false,
  },
  contrast_filetypes = { "terminal", "qf" },
}
