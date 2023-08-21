if exists('g:plugs["vim-fugitive"]')
  " Code Control / Versioning :: Git
  function! ToggleFugitive()
      if buflisted(bufname('.git/index'))
          bd .git/index
      else
          Git
      endif
  endfunction

  function! s:ToggleBlame()
      if &l:filetype ==# 'fugitiveblame'
          close
      else
          Git blame
      endif
  endfunction

  function! ToggleGstatus() abort
    for l:winnr in range(1, winnr('$'))
      if !empty(getwinvar(l:winnr, 'fugitive_status'))
        exe l:winnr 'close'
        return
      endif
    endfor
    keepalt Git
  endfunction

  " Keymaps 
  nnoremap <leader>tf :call ToggleGstatus()<CR>
  nnoremap <leader>tb :call <SID>ToggleBlame()<CR>
  nnoremap <leader>tg :SignifyToggle<CR>
endif
