echom 'loading fzf config'
if exists('g:plugs["fzf"]')
  let g:fzf_buffers_jump = 1
  let g:fzf_preview_window = (&columns >=120 ? 'right:65%' : (&lines > 50 ? 'up:50%' : '')) " Enable allways preview on the right
  " let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } } " use a popup like window instead of a split
  let g:fzf_layout = { 'down': '~60%' } 
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

  function! FZFRunning()
    let buffers = filter(range(1, bufnr('$')), 'bufname(v:val) =~? ".*;#FZF"')
    for i in buffers
      " Delete buffer by ID
      execute 'bw! ' . i
    endfor
    "fixes window focus issues"
    sleep 10m 
  endfunction
  
  function! FZFRunCommand(fzf_command, ...)
    call FZFRunning()
    execute a:fzf_command . ' ' . join(a:000, ' ')
  endfunction
  command! -nargs=+ FZFRun call FZFRunCommand(<f-args>) " this command will
  " rehuse existing fzf window if exists
 
  function! ToggleFZFCommand(fzf_command, ...)
    " Find all FZF buffers
    let fzf_buffers = filter(range(1, bufnr('$')), 'bufname(v:val) =~? ".*;#FZF"')
    if !empty(fzf_buffers)
      " If FZF buffers exist, close them by id and ret<D-s>urn
      for buf in fzf_buffers
        execute 'bw! ' . buf
      endfor
    else
      echom 'None found, running FZF'
      execute a:fzf_command . ' ' . join(a:000, ' ')
    endif
  endfunction
  " command! -nargs=+ FZFRun call ToggleFZFCommand(<f-args>)

" KEYMAPS 
  nnoremap <silent> <C-p> :execute system('git rev-parse --is-inside-work-tree') =~ 'true' ? 'FZFRun :GFiles' : 'FZFRun :Files'<CR>
  inoremap <C-p> <C-o> :FZFRun :Files<CR>
  " noremap <silent> <leader>ff :FZFRun :Files<CR>
  noremap <silent> <leader>fF :FZFRun :Files!<CR> " Full Screen

  " nnoremap <leader>b :FZFRun :Buffers<CR> 
  nnoremap <leader>c :FZFRun :Commands<CR>
  nnoremap <leader>fb :FZFRun :Buffers<CR> 
  nnoremap <leader>fc :FZFRun :Colors<CR>
  nnoremap <leader>fh :FZFRun :Helptags<CR>
  nnoremap <leader>fm :FZFRun :Maps<CR>

  if executable('ag')
    :let $FZF_DEFAULT_COMMAND='ag -l --nocolor --hidden -g ""'
    nnoremap <leader>s :FZFRun :Ag <C-R><C-W><CR>
    nnoremap <leader>* :FZFRun :Ag <C-R><C-W><CR>
    nnoremap <leader>f :FZFRun :Ag<SPACE>
    nnoremap <C-F> :FZFRun :Ag<SPACE>
    inoremap <C-F> <C-O>:FZFRun :Ag<SPACE>
  elseif executable('rg')
    :let $FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'
    nnoremap <leader>s :FZFRun :FZFRun :Rg <C-R><C-W><CR>
    nnoremap <leader>* :FZFRun :Rg <C-R><C-W><CR>
    nnoremap <leader>f :FZFRun :Rg<SPACE>
    nnoremap <C-F> :FZFRun :Rg<SPACE>
    inoremap <C-F> <C-O>:FZFRun :Rg<SPACE>
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
