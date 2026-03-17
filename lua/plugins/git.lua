return {
  { 'tpope/vim-fugitive',
    enabled = true,
    lazy = true,
    cmd = {
      'G',
      'Git',
    },
    config = function()
      local last_head = vim.fn.FugitiveHead()

      vim.api.nvim_create_autocmd('FugitiveChanged', {
        group = vim.api.nvim_create_augroup('FugitiveLspRestartOnBranchChange', { clear = true }),
        callback = function()
          local head = vim.fn.FugitiveHead()
          if head ~= last_head then
            last_head = head
            vim.cmd('LspRestart')
          end
        end,
      })
    end,
  },
  { 'idanarye/vim-merginal',
    enabled = true,
    lazy = true,
    cmd = { 'Merginal', 'MerginalToggle' },
  },
  { 'lewis6991/gitsigns.nvim',
    enabled = true,
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      signcolumn = true,
      numhl = true,
      current_line_blame = false,
      on_attach = function(bufnr)
	local gitsigns = require('gitsigns')
      vim.keymap.set('n', '<leader>tb', '<cmd>Gitsigns toggle_current_line_blame<cr>', { buffer = bufnr, desc = 'Toggle Line Blame', noremap = true, silent = true })
      vim.keymap.set('n', '<leader>tg', '<cmd>Gitsigns toggle_signs<cr>', { buffer = bufnr, desc = 'Toggle GitSigns', noremap = true, silent = true })
    end
  }
  }

}
