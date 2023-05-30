
" Define prefix dictionary
let g:which_key_map =  {}
" Reload Vim Config
let g:which_key_map.v = {
  \ 'name' : '+vim',
  \ 'r': 'Reload config',
  \ 'c': 'Open vim config'
  \ }

" Toggle section
let g:which_key_map.t = {
  \ 'name' : '+toggle',
  \ 'f' : 'Fugitive',
  \ 'b' : 'Git Blame',
  \ 'g' : 'Git Signify',
\}

call which_key#register('<leader>', "g:which_key_map")
" Show leader-help
noremap <silent> <leader><leader> :WhichKey '<Space>'<CR>
