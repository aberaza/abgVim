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
" NBind 'gp', ':PlugConfigEditUnderCursor<CR>'
NBind '<leader>vr', ':source $MYVIMRC<CR>', { 'desc' : 'Reload Config'}
NBind '<leader>vc', ':e $MYVIMRC<CR>', { 'desc' : 'Edit Config'}
" }

nmap <silent><C-DOWN> :cnext<CR>
nmap <silent><C-UP> :cprevious<CR>

" CTRL-Z is Undo; not in cmdline though
noremap <C-Z> u 			" visual and normal modes
IBind '<C-Z>', '<C-O>u' " insert mode
" CTRL-Y is Redo (although not repeat); not in cmdline though
noremap <C-Y> <C-R>
NBind '<C-Y>', '<C-O><C-R>'
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
VBind 'p', '\"_dP'
snoremap <silent>p "_dP
" Switch buffers
noremap <S-h> :bprevious<CR>
noremap <S-l> :bnext<CR>
" Move selected line / block of text in visual mode
" Replaced by mini.move
" nnoremap <M-up> mz:m-2<CR>`z==
" nnoremap <M-down> mz:m+<CR>`z==
" vnoremap <M-up> :m'<-2<CR>gv=`>my`<mzgv`yo`z
" vnoremap <M-down> :m'>+<CR>gv=`<my`>mzgv`yo`z 

" ESC in terminal kills it. Original posed an issue with FZF so updating it 
if has('nvim')
    " :tnoremap <Esc> <C-\\><C-n>
    tnoremap <expr> <Esc> (&filetype == "fzf") ? "<Esc>" : "<c-\><c-n>"
endif

" Use CTRL-S for saving, also in Insert mode
" noremap <C-S>	  :update<CR>
NBind '<C-S>', ':update<CR>', { 'desc': 'Save current buffer'}
VBind '<C-S>', '<C-C>:update<CR>', { 'desc': 'Save current buffer'}
IBind '<C-S>', '<C-O>:update<CR>', { 'desc': 'Save current buffer'}


" Toggle the quickfix window {{{
" From Steve Losh, http://learnvimscriptthehardway.stevelosh.com/chapters/38.html
" NBind '<C-q>', ':call <SID>QuickfixToggle()<cr>'
NBind '<C-q>', ':call abg#quickfix_toggle()<cr>', { 'desc': 'Toggle Quickfix window'}

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
" nnoremap <silent> <F8> :call abg#rotate_colors(1)<CR>
NBind '<F8>', ':call abg#rotate_colors(1)<CR>'
NBind '<S-F8>', ':call abg#rotate_colors()<CR>'


" Register  all bindings
execute 'BindApply'
