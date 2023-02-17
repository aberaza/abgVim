" Errors Warnings Bugs
" Symbols from nerdfonts:     ﮖ           謹            
"                   ﮏ ﰸ  ﲲ            﫵 ﱗ ﮢ 戴  塚 
"    ﴫ 
" Gutter/column symbols
let g:lint_error_sign   = ''
let g:lint_warn_sign    = ''
let g:style_error_sign  = ''
let g:style_warn_sign   = ''

"Linting ALE  {
if exists('g:plugs["ale"]')
  " let g:ale_completion_enabled = 1    " For now allow ALE to add suggestions
  " (not needed, use deoplete)
  let g:ale_fix_on_save = 1           " Lint on save
  let g:ale_open_list = 1             " Open LWindow on errors
  let g:ale_keep_list_window_open = 1 " Keep it open all the time
  let g:ale_list_window_size=5        " Resize it to 5 lines
  let g:ale_fixers = {
        \ '*': ['remove_trailing_lines', 'trim_whitespace'],
        \ 'javascript': ['eslint']
        \}
  let g:ale_sign_error         = g:lint_error_sign " ⏺ ⏺ • ✗
  let g:ale_sign_warning       = g:lint_warn_sign " ⏺ ⬤  • ⚠
  let g:ale_sign_style_error   = g:style_error_sign " 'ﮙ'  ''
  let g:ale_sign_style_warning = g:style_warn_sign "''  ''
  "  " ALEErrorSign guifg=darkred
  "  " red
  "  " Change how signs are colorized. BG remains same, color only to the symbol
  "  " hi ALEErrorSign ctermbg=NONE ctermfg=red
  "  " hi ALEErrorSign ctermfg=red ctermbg=none
  "  " highlight ALEWarningSign ctermbg=NONE ctermfg=yellow
  " hi ALEErrorSign cterm=bold ctermfg=161 ctermbg=NONE gui=bold guifg=#F92672 guibg=NONE
  " hi ALEWarningSign cterm=bold ctermfg=208 ctermbg=NONE gui=bold guifg=#FD971F guibg=NONE
endif
" }
