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
  nnoremap <leader>gs :call ToggleFugitive()<CR>
  nnoremap <leader>gb :call <SID>ToggleBlame()<CR>
  nnoremap <leader>gg :SignifyToggle<CR>

  let g:which_key_map.g = {
        \ 'name': '+git',
        \ 's': 'toggle git status',
        \ 'b': 'toggle git blame',
        \ 'g': 'toggle git signify',
        \  }
endif
