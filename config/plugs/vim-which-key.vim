

call which_key#register('<Space>', "g:which_key_map")

" Define prefix dictionary
let g:which_key_map =  {}
" Reload Vim Config
let g:which_key_map.v = {
  \ 'name' : '+vim',
  \ 'r': 'Reload config',
  \ 'c': 'Open vim config'
  \ }

" Show leader-help
noremap <silent> <leader><leader> :WhichKey '<Space>'<CR>
