if exists('g:plugs["vim-signify"]')
  let g:signify_sign_add               = '▌'""'┃' "┃❘| |
  let g:signify_sign_delete            = '▌'""'┃' "▎⎜⎢▌
  let g:signify_sign_delete_first_line = '_'""'󰘢' ""'‾' 
  let g:signify_sign_change            = '▌'""'┃' "▌
  let g:signify_sign_change_delete     = '󱋱'

  " Colores aunque al cargarse antes que el tema no siempre se ven
  highlight SignifySignAdd             ctermfg=048 ctermbg=NONE guifg=#1FED86 guibg=NONE
  highlight SignifySignChange          ctermfg=147 ctermbg=NONE guifg=#8239F3 guibg=NONE
  highlight SignifySignDelete          ctermfg=202 ctermbg=NONE guifg=#FF1E23 guibg=NONE
  highlight SignifySignDeleteFirstLine ctermfg=red ctermbg=NONE guifg=red     guibg=NONE
" " Waiting for Coc-git PR for proper highlighting
" " ---------------------------------------------------------
" highlight DiffAdd                    ctermfg=048 ctermbg=NONE guifg=#1FED86 guibg=NONE
" highlight DiffChange                 ctermfg=147 ctermbg=NONE guifg=#8239F3 guibg=NONE
" highlight DiffDelete                 ctermfg=202 ctermbg=NONE guifg=#FF1E23 guibg=NONE
" highlight DiffDelete                 ctermfg=red ctermbg=NONE guifg=red     guibg=NONE
endif

