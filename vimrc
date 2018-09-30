" Environment {
    " Basics {
        set nocompatible " Must be first line
        set encoding=utf-8
        setglobal fileencoding=utf-8

        let mapleader = " " " Leader : Spacebar
        
        " Todo: This should go into a local file, not here
        if has('win32') || has('win64')
            cd ~/WORKSPACE
        else
            set shell=/bin/bash
        endif
    " }
" }

" General {
    filetype plugin indent on       " Use file indents specific to each filetype
    set runtimepath+=$HOME/.vim " Needed for windows?

    syntax on " Syntax highlighting
    set mouse=a " Automatically enable mouse usage
    set mousehide " Hide the mouse cursor while typing
    set ffs=unix,dos,mac " set fileformat

    if has('clipboard') && has('unnamedplus')
        set clipboard=unnamedplus " use + register for copy-paste
    endif

    "set autowrite " Automatically write a file when leaving a modified buffer
    set shortmess+=filmnrxoOtT " Abbrev. of messages (avoids 'hit enter')
    set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
    set virtualedit=onemore " Allow for cursor beyond last character
    set history=100 " Store a ton of history (default is 20)
    " set spell " Spell checking on
    set hidden " Allow buffer switching without saving
    set winminheight=0 " Windows can be 0 line high
    set wildmenu                    " Show list instead of just completing
    set completeopt=menuone,preview

    " Search {
        set incsearch " Find as you type search
        set hlsearch " Highlight search results
        set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
        set wildignore=*.swp,*.bak,*.pyc,*.class,*.o
        set ignorecase " Case insensitive search
        set smartcase " Case sensitive when uc present
        set gdefault    " /g by default on searches
    " }
    set list
    set listchars=tab:→\ ,extends:›,precedes:‹,nbsp:·,trail:• " Highlight whitespaces
    set showbreak=↪\  " char to display on a wrapped line
    set scrolljump=5                " Lines to scroll when cursor leaves screen
    set scrolloff=3                 " Minimum lines to keep above and below cursor
    set sidescrolloff=5             " Minimum cols to keep left and right from cursor
    set backspace=indent,eol,start  " Backspace for dummies
    set whichwrap=b,s,h,l,<,>,[,] " Backspace and cursor keys wrap too
    set visualbell "don't beep
    "set noerrorbells "do nothing on error

    " Folding {
        set foldenable          " Auto fold code
        nnoremap <space> za
        set foldlevelstart=99   " open all folds by defailt
        set foldmethod=indent   " Folding method. One of indent, marker, manual, expr, syntax or diff
    " }

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
" }


" Bundles {
    if filereadable(expand("~/.vim/config/vimrc.bundles"))
        source ~/.vim/config/vimrc.bundles
        if filereadable(expand("~/.vim/config/vimrc.bundlesConfig"))
            source ~/.vim/config/vimrc.bundlesConfig
        endif
    endif
" }

" UI enhancements {
    set cursorline              " Highlight current line
    set number                  " Line numbers on
    set showmatch               " Show matching brackets/parenthesis
    set tabpagemax=15           " Only show 15 tabs
    set showcmd                 " Show last command on bottom right

    set t_Co=256 " Enable 256 colors to stop the CSApprox warning and make xterm vim shine
    if(has("termguicolors"))
        set termguicolors
    endif

    set background=dark

    color molokayo

    set fillchars=vert:│,fold:- " make vertical lines look continuous

    " GVIM- (here instead of .gvimrc)
        if has('gui_running')
            set guioptions-=T   " Remove the toolbar
            set go-=L           " Hide left scrollbars
            set go-=r           " Hide right scrollbars
            set go+=e           " Native toolkit tabs
            set go-=m           " Remove top text menu
            set guioptions-=a   " For CTRL-V to work disable autoselect
            set lines=40        " 40 lines of text instead of 24
            nnoremap <C-F9> :if &go=~#'m'<Bar>set go-=m<Bar>else<Bar>set go+=m<Bar>endif<CR>
            if has('win32') || has('win64')
                set guifont=DejaVuSansMono_Nerd_Font_Mono:h11,DejaVu_Sans_Mono_for_Powerline:h10
                " Use direct x for rendering
                set rop=type:directx,gamma:1.2,level:1.0,contrast:0.25,geom:1,taamode:1,renmode:5 " renmode:3 tambien va bien
                " nnoremap <F9> :set rop=type:directx,gamma:1.5,level:0.75,contrast:0.5;taamode:0;renmode:0<CR>
            else
                set guifont=DejaVuSansMono\ Nerd\ Font\ Mono\ 9,DejaVu\ Sans\ Mono\ \for\ Powerline\ 9,DejaVu\ Sans\ Mono\ 9
            endif
        else
            if exists('g:GuiLoaded')
                GuiFont DejaVuSansMono NF:h10
            elseif &term == 'xterm' || &term == 'screen'
            endif
        endif
    " }
" }



" Formatting {
    set linespace=0                 " No extra spaces between rows
    set nowrap          " Do not wrap long lines
    set autoindent      " Indent at the same level of the previous line
    set copyindent      " copy previous inddentation on autoindent
    set smarttab        " insert tabs on start of line accoding to shiftwidth
    set shiftwidth=2    " Use indents of 4 spaces
    set expandtab       " Tabs are spaces, not tabs
    set tabstop=2       " Spaces for each TAB press when typing
    set softtabstop=4   " Convert TAB to spaces when reading a file
    set nojoinspaces    " Prevents inserting two spaces after punctuation on a join (J)
    set splitright splitbelow " Puts new vsplit windows to the right and bottom of the current
    set matchpairs+=<:> " Match, to be used with % (add HTML style)
" }

" KeyMappings {
    if filereadable(expand("~/.vim/config/vimrc.keymaps"))
        source ~/.vim/config/vimrc.keymaps
    endif
" }

" Autocommands/Settings per file type {
    if filereadable(expand("~/.vim/config/vimrc.autocmds"))
        source ~/.vim/config/vimrc.autocmds
    endif
" }

" Abbreviations {
    cnoreabbrev W! w!
    cnoreabbrev Q! q!
    cnoreabbrev Qall! qall!
    cnoreabbrev Wq wq
    cnoreabbrev Wa wa
    cnoreabbrev wQ wq
    cnoreabbrev WQ wq
    cnoreabbrev W w
    cnoreabbrev Q q
    cnoreabbrev Qall qall
" }

" Local settings file {
    if filereadable(expand("~/.vim/vimrc.local"))
        source ~/.vim/vimrc.local
    endif
" }

" Some autocommands
if has('nvim')
    au FocusGained,BufWinEnter * checktime
endif
