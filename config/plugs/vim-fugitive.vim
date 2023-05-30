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

  " Keymaps 
  nnoremap <leader>tf :call ToggleFugitive()<CR>
  nnoremap <leader>tb :call <SID>ToggleBlame()<CR>
  nnoremap <leader>tg :SignifyToggle<CR>
endif
