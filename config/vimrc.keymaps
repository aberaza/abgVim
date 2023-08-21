" Most important setting: map <leader> {
let mapleader = "\<Space>" " <leader> == Spacebar
let g:mapleader = "\<Space>" " <leader> == Spacebar
let g:maplocalleader = "," " <leader> == Spacebar
" }

" Abbreviations / Typos {
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qa! qa!
cnoreabbrev Qa qa
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev X x
" }

" Config files {
nnoremap gp :PlugConfigEditUnderCursor<CR>
nnoremap <leader>vr :source $MYVIMRC<CR>
nnoremap <leader>vc :e $MYVIMRC<CR>
" }

nmap <silent><C-DOWN> :cnext<CR>
nmap <silent><C-UP> :cprevious<CR>

" CTRL-Z is Undo; not in cmdline though
noremap <C-Z> u 			" visual and normal modes
inoremap <C-Z> <C-O>u " insert mode
" CTRL-Y is Redo (although not repeat); not in cmdline though
noremap <C-Y> <C-R>
inoremap <C-Y> <C-O><C-R>
" CTRL-A is Select all
" noremap <C-A> gggH<C-O>G
" inoremap <C-A> <C-O>gg<C-O>gH<C-O>G
" cnoremap <C-A> <C-C>gggH<C-O>G
" onoremap <C-A> <C-C>gggH<C-O>G
" snoremap <C-A> <C-C>gggH<C-O>G
" xnoremap <C-A> <C-C>ggVG
" CTRL-Tab is Next window
" noremap  <C-Tab> <C-W>w
" inoremap <C-Tab> <C-O><C-W>w
" cnoremap <C-Tab> <C-C><C-W>w
" onoremap <C-Tab> <C-C><C-W>w
" Window switch CTRL-Arrows
noremap <C-Up> <C-w>k
noremap <C-Down> <C-w>j
noremap <C-Left> <C-w>h
noremap <C-Right> <C-w>l
" Window resize
noremap <C-H> <Cmd>vertical resize -<CR>
noremap <C-J> <Cmd>resize -<CR>
noremap <C-K> <Cmd>resize +<CR>
noremap <C-L> <Cmd>vertical resize +<CR>
" Paste in place without yanking text
vnoremap <silent>p "_dP
snoremap <silent>p "_dP
" Switch buffers
noremap <S-h> :bprevious<CR>
noremap <S-l> :bnext<CR>
" Move selected line / block of text in visual mode
nnoremap <M-up> mz:m-2<CR>`z==
nnoremap <M-down> mz:m+<CR>`z==
vnoremap <M-up> :m'<-2<CR>gv=`>my`<mzgv`yo`z
vnoremap <M-down> :m'>+<CR>gv=`<my`>mzgv`yo`z 

" ESC in terminal kills it. Original posed an issue with FZF so updating it 
if has('nvim')
    " :tnoremap <Esc> <C-\\><C-n>
    tnoremap <expr> <Esc> (&filetype == "fzf") ? "<Esc>" : "<c-\><c-n>"
endif

" Use CTRL-S for saving, also in Insert mode
noremap <C-S>	  :update<CR>
vnoremap <C-S>  <C-C>:update<CR>
inoremap <C-S>  <C-O>:update<CR>

" Toggle the quickfix window {{{
" From Steve Losh, http://learnvimscriptthehardway.stevelosh.com/chapters/38.html
nnoremap <C-q> :call <SID>QuickfixToggle()<cr>

let g:quickfix_is_open = 0

function! s:QuickfixToggle()
    if g:quickfix_is_open
        cclose
        let g:quickfix_is_open = 0
        execute g:quickfix_return_to_window . "wincmd w"
    else
        let g:quickfix_return_to_window = winnr()
        copen
        let g:quickfix_is_open = 1
    endif
endfunction
" }}}

" Expand-region {
" vmap v <Plug>(expand_region_expand)
" vmap V <Plug>(expand_region_shrink)
" }

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

" Rotate favourite color themes
nnoremap <silent> <F8> :call abg#rotate_colors(1)<CR>
nnoremap <silent> <S-F8> :call abg#rotate_colors()<CR>
