return {
  { 'echasnovski/mini.pick', 
  opts={},
  setup = function()
    -- some colorschemes
    vim.api.nvim_set_hl(0, "MiniPickMatchCurrent", {link ="Green"})
    vim.api.nvim_set_hl(0, "MiniPickMatchMarked", {link ="Blue"})
    vim.api.nvim_set_hl(0, "MiniPickMatchRanges", {link ="Red"})
    vim.ui.select = MiniPick.ui_select
  end
  }
}
