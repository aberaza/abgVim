if exists('g:plugs["fzf"]')
  let g:fzf_buffers_jump = 1
  let g:fzf_preview_window = (&columns >=120 ? 'right:40%' : (&lines > 50 ? 'up:50%' : '')) " Enable allways preview on the right
  let g:fzf_layout = { 'down' : '~25%' }
  " let g:fzf_layout = { 'window': { 'width': 0.9, 'height':0.7 } }
  if executable('ag')
    :let $FZF_DEFAULT_COMMAND='ag -l --nocolor --hidden -g ""'
  endif

  " Inspired in FZF-vim
  function! s:p(bang, opts)
    let preview_window = a:bang ? '' : g:fzf_preview_window
    echom preview_window
    if len(preview_window)
      return call('fzf#vim#with_preview', add([a:opts], preview_window))
    endif
    return a:opts
  endfunction

  command! -bang -nargs=* AgFiles
        \ call fzf#vim#files('',
        \ s:p(<bang>0, {'source': 'ag --hidden -f -g ""'} ))

" KEYMAPS 
" Ctrl-P for files
" Ctrl-F Find in files
" Alt-B for buffers
"
  noremap <silent> <C-p> :Files<CR>
  noremap <silent> <A-b> :Buffers<CR>
  noremap <silent> <leader>vt :Colors<CR>
  noremap <silent> <leader>vh :Helptags<CR>
  noremap <silent> <leader>vk :Maps<CR>
  " TODO: conflicts with autocmplete?
  inoremap <silent> <C-p> <C-o>:Files<CR>
  noremap <silent> <leader>p :Files<CR>
  noremap <silent> <leader>P :Files!<CR> " Full Screen
  " Leave fzf with CtrlP or ESC
  if has("nvim")
    autocmd FileType fzf tnoremap <buffer> <Esc> <Esc>
    autocmd FileType fzf tnoremap <C-P> <Esc> <Esc>
  endif

  nnoremap <Leader>s :Ag <C-R><C-W><CR>
  nnoremap <Leader>* :Ag <C-R><C-W><CR>
  " <,F> or <Ctrl+F> To do a workspace search
  " This breaks original Ctrl F (scroll on page down)
  nnoremap <Leader>f :Ag<SPACE>
  nnoremap <C-F> :Ag<SPACE>
  inoremap <C-F> <C-O>:Ag<SPACE>
endif
