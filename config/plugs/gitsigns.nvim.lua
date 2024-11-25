local status, gitsigns = pcall(require, 'gitsigns')
if( not status) then return end

gitsigns.setup({
  signcolumn = true,
  numhl = true,
  current_line_blame = false,
  on_attach = function(bufnr)
    local gitsigns = require('gitsigns')


    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end
    -- Actions}
    map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
    map('n', '<leader>hb', function() gitsigns.blame_line{full=true} end) 
  end
})
