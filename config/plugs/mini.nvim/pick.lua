local status, pick = pcall(require, 'mini.pick')
if (not status) then return end

pick.setup()
-- Colorscheme picker =======================================================

vim.ui.select = MiniPick.ui_select
-- local selected_colorscheme -- Currently selected or original colorscheme
MiniPick.registry.colorschemes = function()
  local colorschemes = vim.fn.getcompletion("", "color")
  return MiniPick.start({
    source = {
      name = "Colorschemes",
      items = colorschemes,
      choose = function(item) 
        pcall(function() vim.cmd("colorscheme " .. item) end) 
      end,
      preview =  function(buf_id, item)
        pcall(function() vim.cmd("colorscheme " .. item) end)
        vim.api.nvim_buf_set_lines(buf_id, 0, -1, false, { item })
      end,
    },
  })
end
local set_colorscheme = function(name)
  pcall(function()
    vim.cmd("Colorscheme " .. name) -- Usa mini.colors Colorscheme para animar transición
  end)
end
-- Keymaps!
vim.keymap.set({'n','v'},"<leader>ff",  "<cmd>Pick files<CR>", { desc ="Find files"})
vim.keymap.set({'n','v'},"<leader>fb",   "<cmd>Pick buffers<CR>",{ desc = "Switch buffer"})
vim.keymap.set({'n','v'}, "<leader>fbs",   "<cmd>Pick buf_lines scope='current'<CR>",{ desc= "Search buffer"} )
-- vim.keymap.set("n", "<leader>fc", pick_colorscheme, { noremap = true, silent = true, desc = 'Change Colorscheme' })

-- I see not many isssues in this project
