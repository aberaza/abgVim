local status, llines = pcall(require, 'lsp_lines')
if not status then return end

vim.cmd [[autocmd! CursorHold * lua vim.diagnostic.config({ virtual_lines = { only_current_line = true } })]]
-- Disable virtual_text since it's redundant due to lsp_lines.
vim.diagnostic.config({
  virtual_text = false,
})

vim.keymap.set(
  "",
  "<leader>l",
  llines.toggle,
  { desc = "Toggle lsp_lines" }
)
