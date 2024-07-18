if exists('g:plugs["fzf"]')
  let g:fzf_buffers_jump = 1
  let g:fzf_preview_window = (&columns >=120 ? 'right:40%' : (&lines > 50 ? 'up:50%' : '')) " Enable allways preview on the right
  let g:fzf_layout = { 'down' : '~25%' }
  " let g:fzf_layout = { 'window': { 'width': 0.9, 'height':0.7 } }

" Customize fzf colors to match your color scheme                                          
    " - fzf#wrap translates this to a set of `--color` options                                 
    let g:fzf_colors =                                                                         
    \ { 'fg':      ['fg', 'Normal'],                                                           
      \ 'bg':      ['bg', 'Normal'],                                                           
      \ 'hl':      ['fg', 'Comment'],                                                          
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],                             
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],                                       
      \ 'hl+':     ['fg', 'Statement'],                                                        
      \ 'info':    ['fg', 'PreProc'],                                                          
      \ 'border':  ['fg', 'Ignore'],                                                           
      \ 'prompt':  ['fg', 'Conditional'],                                                      
      \ 'pointer': ['fg', 'Exception'],                                                        
      \ 'marker':  ['fg', 'Keyword'],                                                          
      \ 'spinner': ['fg', 'Label'],                                                            
      \ 'header':  ['fg', 'Comment'] }
  " Inspired in FZF-vim
  function! s:p(bang, opts)
    let preview_window = a:bang ? '' : g:fzf_preview_window
    if len(preview_window)
      return call('fzf#vim#with_preview', add([a:opts], preview_window))
    endif
    return a:opts
  endfunction

" KEYMAPS 
  nnoremap <silent> <C-p> :execute system('git rev-parse --is-inside-work-tree') =~ 'true' ? 'GFiles' : 'Files'<CR>
  inoremap <C-p> <C-o> :Files<CR>
  noremap <silent> <leader>ff :Files<CR>
  noremap <silent> <leader>fF :Files!<CR> " Full Screen

  nnoremap <leader>b :Buffers<CR> 
  nnoremap <leader>c :Commands<CR>
  nnoremap <leader>fb :Buffers<CR> 
  nnoremap <leader>fc :Colors<CR>
  nnoremap <leader>fh :Helptags<CR>
  nnoremap <leader>fm :Maps<CR>


  if executable('ag')
    :let $FZF_DEFAULT_COMMAND='ag -l --nocolor --hidden -g ""'
    nnoremap <leader>s :Ag <C-R><C-W><CR>
    nnoremap <leader>* :Ag <C-R><C-W><CR>
    " <,F> or <Ctrl+F> To do a workspace search
    " This breaks original Ctrl F (scroll on page down)
    nnoremap <leader>f :Ag<SPACE>
    nnoremap <C-F> :Ag<SPACE>
    inoremap <C-F> <C-O>:Ag<SPACE>
  elseif executable('rg')
    :let $FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'
    nnoremap <leader>s :Rg <C-R><C-W><CR>
    nnoremap <leader>* :Rg <C-R><C-W><CR>
    " <,F> or <Ctrl+F> To do a workspace search
    " This breaks original Ctrl F (scroll on page down)
    nnoremap <leader>f :Rg<SPACE>
    nnoremap <C-F> :Rg<SPACE>
    inoremap <C-F> <C-O>:Rg<SPACE>
  endif


  " Statusline for FZF window
  function! s:fzf_statusline()
  " Override statusline as you like
    highlight fzf1 ctermfg=161 ctermbg=251
    highlight fzf2 ctermfg=23 ctermbg=251
    highlight fzf3 ctermfg=237 ctermbg=251
    setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
  endfunction

  autocmd! User FzfStatusLine call <SID>fzf_statusline()
endif
