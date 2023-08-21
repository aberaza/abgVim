if exists('g:plugs["vimspector"]')
  let g:vimspector_enable_mappings = 'HUMAN' " 'VISUAL_STUDIO'  HUMAN
  if NEOVIM()
    " Some workarounds for neovim
    " for normal mode - the word under the cursor
    nmap <Leader>di <Plug>VimspectorBalloonEval
    " for visual mode, the visually selected text
    xmap <Leader>di <Plug>VimspectorBalloonEval
  endif
endif
