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
endif
