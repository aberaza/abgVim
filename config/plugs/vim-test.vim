if exists('g:plugs["vim-test"]')
  if NEOVIM()
    let test#strategy = "neovim"
    let g:test#preserve_screen = 1
    " Keys configured in neotest.lua
  else
  " Con Vim8:
  " use dispatch for vim-test
    let test#strategy = "dispatch"
    let g:test#preserve_screen = 1
  endif

endif
