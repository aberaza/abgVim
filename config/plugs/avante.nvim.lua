local status, avante = pcall(require, 'avante.utils')
if (not status) then return end

-- configure avante.nvim to use copilot as provider 

avante.setup({
  provider="copilot",
  behaviour = {
    auto_suggestions = false,
    auto_set_keymaps = true,
    support_paste_from_clipboard = true,
  }
})

