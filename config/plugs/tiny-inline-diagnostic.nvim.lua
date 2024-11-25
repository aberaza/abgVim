local status, tiny = pcall(require, 'tiny-inline-diagnostic')
if (not status) then return end

tiny.setup({
  options = {
    show_soource = true,
    throttle=100,
  }
})

vim.keymap.set(
  "",
  "<leader>l",
  tiny.toggle,
  { desc = "Toggle inline diagnostic" }
)

-- Disable virtual_text since it's redundant.
vim.diagnostic.config({
  virtual_text = false,
})
