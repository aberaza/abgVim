" File Formatting {
set encoding=utf-8
setglobal fileencoding=utf-8
" }

" Formatting {
" Indenting, Tabs and Spaces
set expandtab       " Use spaces by default
set tabstop=2       " 2 Spaces for each TAB press when typing
set softtabstop=2   " <BS> pretends to remove a tab
set shiftwidth=2    " Use indents of 2 spaces
set shiftround      " Use multiples of shitwidth when indenting with <,>
set autoindent      " Indent at the same level of the previous line
set copyindent      " copy previous inddentation on autoindent
set smarttab        " insert tabs on start of line accoding to shiftwidth
set nojoinspaces    " Prevents inserting two spaces after punctuation on a join (J)

set matchpairs+=<:> " Match, to be used with % (add HTML style)
" }
"
"
" General {
" Windows
set splitright splitbelow " Puts new vsplit windows to the right and bottom of the current

" Mouse Support
set backspace=indent,eol,start  " Backspace for dummies
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
set visualbell                  "don't beep
set noerrorbells                "do nothing on error

" files, encodings and more
filetype plugin indent on       " Use file indents specific to each filetype
set ffs=unix,dos,mac " set fileformat
" set formatoptions+=jc1 " Delete comment character when joining commented lines, wrap comments, split before 1 letter words 
set formatoptions=qjc1l
set runtimepath+=$HOME/.vim     " TODO: Needed for windows?


" Copy paste and delete
if has('clipboard') && has('unnamedplus')
  set clipboard=unnamedplus " use + register for copy-paste
endif

set autowrite " Automatically write a file when leaving a modified buffer
set shortmess+=filmnrxoOtT " Abbrev. of messages (avoids 'hit enter')
set sessionoptions-=options " Same values for vim and nvim
set viewoptions=folds,cursor,curdir,unix " Better Unix / Windows compatibility
set virtualedit=onemore,block " Allow for cursor beyond last character
set history=300 " Store a ton of history (default is 20)
" set spell " Spell checking on
set hidden " Allow buffer switching without saving
set completeopt=menuone,preview,noinsert,noselect " Show complete menu even when only one match

" Search {
set incsearch " Find as you type search
set hlsearch " Highlight search results
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
set wildignore=*.swp,*.bak,*.pyc,*.class,*.o
set ignorecase " Case insensitive search
set smartcase " Case sensitive when uc present
" }

" persistent undo 

" Manage backup files {
set backupdir=~/vimtmp
set backupskip=~/vimptmp/*
set directory=~/vimptmp
set undodir=~/.vimtmp/
"set backup
set nobackup
set nowritebackup
set noswapfile
" }
