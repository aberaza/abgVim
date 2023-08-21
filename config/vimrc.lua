-- Diagnostics 
local signs = { Error = "✘", Warn = "▲", Hint = "⚑", Info = "" }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl= hl, numhl = hl })
end


require('glow').setup()


-- Treesitter
vim.opt.foldmethod='expr'
-- set in editor config file
-- vim.opt.completeopt = 'menuone,noinsert,noselect'


