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
    
    " Autosave {
    " From http://vim.wikia.com/wiki/Auto-save_current_buffer_periodically
    " Hay una con autocmd TextChanged que parece muy buena tambien
    " Mirad esta alternativa que parece más limpia aunque menos funcional
    " https://github.com/epeli/neovim-config/blob/master/init.vim 
      " let g:autosave_time=5

      " au BufRead,BufNewFile * let b:last_save_time = localtime() " Save last save on open
      " au BufWritePre * let b:last_save_time = localtime() " Update last save on write
      " au CursorHold * call AutoSaveFile()   " After 300ms of inactivity in normal mode call function
      " " au CursorHoldI * call AutoSaveFile()
      " function! AutoSaveFile()
      "   if(g:autosave_time == 0)
      "     " do nothing
      "   elseif((localtime() - b:last_save_time) >= g:autosave_time)
      "     echo "autosave saved something"
      "     silent! update
      "     let b:save_time = localtime()
      "   endif
      " endfunction
    " }


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
    hi ALEErrorSign cterm=bold ctermfg=161 ctermbg=none gui=bold guifg=#F92672 guibg=none
    hi ALEWarningSign cterm=bold ctermfg=208 ctermbg=none gui=bold guifg=#FD971F guibg=none

    set fillchars=vert:│,fold:- " make vertical lines look continuous

    " GVIM
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
        " NVim-QT
        if exists('g:GuiLoaded')

          let g:fontsize = 9
          let g:fontname = "DejaVuSansMono Nerd Font Mono"
          function! AdjustFontSize(amount)
            let g:fontsize = g:fontsize+a:amount
            :execute "Guifont! " . g:fontname . ":h" . g:fontsize
          endfunction

          function! SetGuiFont(amount)
            let amount = get(a:, "amount", 0)

            let fontname = matchstr(&guifont, '.*\(:h\)\@=')
            let fontsize = matchstr(&guifont, '\(:h\)\@<=\d\+')
            let fontsize = fontsize + amount
            let finalFont = fontname . ":h" . fontsize
            echo &guifont
            echo "Set font " fontname . " h: " . fontsize
            echo finalFont
            " if(has('gui_running')) || exists('g:GuiLoaded')
              :execute "set guifont=" . fontname . ":h" . fontsize
              " :set guifont=finalFont
              if(exists('g:GuiLoaded'))
                :execute "Guifont! " . fontname . ":h" . fontsize
              endif
            " else
            "   echo "AXB::Could not set font"
            " endif
          endfunction

          noremap <C-k1> :call SetGuiFont(55)<CR>
          noremap <C-k2> :call SetGuiFont(0)<CR>
          noremap <C-k3> :call SetGuiFont(1)<CR>
          noremap <C-k4> :call SetGuiFont(-1)<CR>
          

          noremap <C-ScrollWheelUp> :call AdjustFontSize(1)<CR>
          noremap <C-ScrollWheelDown> :call AdjustFontSize(-1)<CR>
          inoremap <C-ScrollWheelUp> <Esc>:call AdjustFontSize(1)<CR>a
          inoremap <C-ScrollWheelDown> <Esc>:call AdjustFontSize(-1)<CR>a
            
          noremap <C-kPlus> :call AdjustFontSize(1)<CR>
          noremap <C-kMinus> :call AdjustFontSize(-1)<CR>
          inoremap <C-kPlus> <Esc>:call AdjustFontSize(1)<CR>a
          inoremap <C-kMinus> <Esc>:call AdjustFontSize(-1)<CR>a

            GuiFont! DejaVuSansMono NF:h9
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
