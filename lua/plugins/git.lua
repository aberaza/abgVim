return {
  { 'tpope/vim-fugitive',
    lazy = true,
    cmd = {
      'G',
      'Git',
    },
    -- config = function()
    -- end
  },
  { 'idanarye/vim-merginal' },
  { 'lewis6991/gitsigns.nvim', enabled = false,
    opts = {
      signcolumn = true,
      numhl = true,
      current_line_blame = false,
      on_attach = function(bufnr)
	local gitsigns = require('gitsigns')

	vim.keymap.set('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = 'Toggle Line Blame', noremap = true, silent = true })
	vim.keymap.set('n', '<leader>hb', function() gitsigns.blame_line{full=true} end, { desc = 'Toggle Line Blame', noremap = true, silent = true })
      end
    }
  }

}
