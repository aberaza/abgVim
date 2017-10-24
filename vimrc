" Environment {
    " Basics {
        set nocompatible " Must be first line
        if has('win32') || has('win64')
            " set 'selection', 'selectmode', 'mousemodel' and 'keymodel' for MS-Windows
            " behave mswin

            if has("multi_byte")
                " Windows cmd.exe still uses cp850. If Windows ever moved to
                set termencoding=cp850
                " Let Vim use utf-8 internally, because many scripts require this
                set encoding=utf-8
                setglobal fileencoding=utf-8
                set fileencodings=ucs-bom,utf-8,utf-16le,cp1252,iso-8859-15
            endif
            " set shell=C:\msys64\usr\bin\bash
            " set shellcmdflag=--login\ -c
            " set shellslash
            cd ~/WORKSPACE
        else
            set shell=/bin/bash
        endif
        let mapleader = " "

    " }
" }

" General {
    filetype plugin indent on " Automatically detect file types.
    set runtimepath+=$HOME/.vim " Needed for windows?
    syntax on " Syntax highlighting
    set mouse=a " Automatically enable mouse usage
    set mousehide " Hide the mouse cursor while typing
    scriptencoding utf-8
    set ffs=unix,dos,mac

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
    set showmatch " Show matching brackets/parenthesis
    set incsearch " Find as you type search
    set hlsearch " Highlight search terms
    set winminheight=0 " Windows can be 0 line high
    set ignorecase " Case insensitive search
    set smartcase " Case sensitive when uc present
    set wildmenu                    " Show list instead of just completing
    set completeopt=menuone,preview
    set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
    set wildignore=*.swp,*.bak,*.pyc,*.class,*.o
    set list
    "set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
    set listchars=tab:→\ ,extends:›,precedes:‹,nbsp:·,trail:• " Highlight whitespaces
    set showbreak=↪\  " char to display on a wrapped line
    set scrolljump=5                " Lines to scroll when cursor leaves screen
    set scrolloff=3                 " Minimum lines to keep above and below cursor
    set sidescrolloff=5             " Minimum cols to keep left and right from cursor
    "set foldenable                  " Auto fold code
    set backspace=indent,eol,start  " Backspace for dummies
    set whichwrap=b,s,h,l,<,>,[,] " Backspace and cursor keys wrap too
    set visualbell "don't beep
    "set noerrorbells "do nothing on error
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
    " comandline info {
        set ruler                   " Show the ruler
        set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
        set showcmd                 " Show partial commands in status line and
    " }

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
                set guifont=DejaVu_Sans_Mono_for_Powerline:h10,DejaVu_Sans_Mono:8,Consolas:h9,Courier_New:h9
                " Use direct x for rendering
                set rop=type:directx,gamma:1.2,level:1.0,contrast:0.25,geom:1,taamode:1,renmode:5 " renmode:3 tambien va bien
                " nnoremap <F9> :set rop=type:directx,gamma:1.5,level:0.75,contrast:0.5;taamode:0;renmode:0<CR>
            else
                set guifont=DejaVu\ Sans\ Mono\ \for\ Powerline\ 9,DejaVu\ Sans\ Mono\ 9,\Monospace\ 9,Andale\ Mono\ Regular\ 9,Menlo\ Regular\ 9,Consolas\ Regular\ 9,Courier\ New\ Regular\ 10
            endif
        else
            if exists('g:GuiLoaded')
                GuiFont DejaVu Sans Mono for Powerline:h10
            elseif &term == 'xterm' || &term == 'screen'
                set t_Co=256 " Enable 256 colors to stop the CSApprox warning and make xterm vim shine
            endif
    "set term=builtin_ansi " Make arrow and other keys work
        endif
    " }
    set background=darkItem
    color PaperColor " molokai,  fruity
    set fillchars=vert:│,fold:- " make vertical lines look continuous

    set showmode " Display the current mode
    set cursorline " Highlight current line
" }



" Formatting {
    set linespace=0                 " No extra spaces between rows
    set nu " Line numbers on
    set nowrap " Do not wrap long lines
    set autoindent " Indent at the same level of the previous line
    set copyindent  " copy previous inddentation on autoindent
    set smarttab " insert tabs on start of line accoding to shiftwidth
    set shiftwidth=4 " Use indents of 4 spaces
    set expandtab " Tabs are spaces, not tabs
    set tabstop=4 " An indentation every four columns
    set softtabstop=4 " Let backspace delete indent
    set tabpagemax=15 " Only show 15 tabs
    set nojoinspaces " Prevents inserting two spaces after punctuation on a join (J)
    set splitright " Puts new vsplit windows to the right of the current
    set splitbelow " Puts new split windows to the bottom of the current
    if v:version > 703 || v:version == 703 && has("patch541")
        set formatoptions+=j " Delete comment character when joining commented lines
    endif
"set matchpairs+=<:> " Match, to be used with %
    set pastetoggle=<F12> " pastetoggle (sane indentation on pastes)
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
    if filereadable(expand("~/.vim/config/vimrc.local"))
        source ~/.vim/config/vimrc.local
    endif
" }

" Some autocommands
if has('nvim')
    au FocusGained,BufWinEnter * checktime
endif
