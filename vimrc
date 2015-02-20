" Environment {
    " Basics {
        set nocompatible " Must be first line
        if has('win32') || has('win64')
            " else if windows and mingw
            " set shell=D:\MinGW\msys\1.0\bin\bash
            " set shellcmdflag=--login\ -c
            " set shellxquote=\"e, if windows and mingw
            source $VIMRUNTIME/vimrc_example.vim
            source $VIMRUNTIME/mswin.vim
            behave mswin

            if has("multi_byte")
                " Windows cmd.exe still uses cp850. If Windows ever moved to
                set termencoding=cp850
                " Let Vim use utf-8 internally, because many scripts require this
                set encoding=utf-8
                set fileencoding=utf-8
                " set fileencodings=ucs-bom,utf-8,utf-16le,cp1252,iso-8859-15
            endif
            cd D:\WORKSPACE
        else
            set shell=/bin/sh
        endif
        let mapleader = ","
    " }
    " Setup Bundle {
        " The next three lines ensure that the ~/.vim/bundle/ system works
        filetype off
        set rtp+=~/.vim/bundle/vundle/
        call vundle#begin()
        " Deps {
            Bundle 'gmarik/vundle'
        " }

        " Themes {
            Plugin 'molokai'
        " }
    " }

" }

" General {
    filetype plugin indent on " Automatically detect file types.
    " set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles,$HOME/.vim,~/.vim/bundle/vundle " Needed for windows?
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
    set history=1000 " Store a ton of history (default is 20)
    " set spell " Spell checking on
    set hidden " Allow buffer switching without saving
    set showmatch " Show matching brackets/parenthesis
    set incsearch " Find as you type search
    set hlsearch " Highlight search terms
    set winminheight=0 " Windows can be 0 line high
    set ignorecase " Case insensitive search
    set smartcase " Case sensitive when uc present
    set wildmenu                    " Show list instead of just completing
    set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
    set scrolljump=5                " Lines to scroll when cursor leaves screen
    set scrolloff=3                 " Minimum lines to keep above and below cursor
    "set foldenable                  " Auto fold code
    set backspace=indent,eol,start  " Backspace for dummies
    " set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
    
	" Manage backup files {
    if 0
		set backup
		set backupdir=~/vimtmp
		set backupskip=~/vimptmp/*
		set directory=~/vimtmp
    else
        set nobackup
        set nowritebackup
        set noswapfile
    endif
    " }
" }


" UI enhancements {
    " Solarizez theme or molokai or fruity
    if filereadable(expand("~/.vim/bundle/vim-colors-solarized/colors/solarized.vim"))
        let g:solarized_termcolors=256
        let g:solarized_termtrans=1
        let g:solarized_contrast="normal"
        let g:solarized_visibility="normal"
        color solarized " Load a colorscheme
    else
		set background=dark
		color molokai " fruity
    endif

    " comandline info {
        set ruler                   " Show the ruler
        set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
        set showcmd                 " Show partial commands in status line and
    " }

    " statusline {
        "set laststatus=2                         " Always show the status line
        "set statusline=%<%f\                     " Filename
        "set statusline+=%w%h%m%r                 " Options
        "set statusline+=%{fugitive#statusline()} " Git Hotness
        "set statusline+=\ [%{&ff}/%Y]            " Filetype
        "set statusline+=\ [%{getcwd()}]          " Current dir
        "set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
    " }

    " GVIM- (here instead of .gvimrc)
        if has('gui_running')
            set guioptions-=T   " Remove the toolbar
            set go-=L           " Hide left scrollbars
            set go-=r           " Hide right scrollbars
            set go+=e           " Native toolkit tabs
            set lines=40        " 40 lines of text instead of 24
            if has('win32')
                set guifont=DejaVu_Sans_Mono_for_Powerline:h8,DejaVu_Sans_Mono:h8,Consolas:h9,Courier_New:h9
            else
                set guifont=DejaVu\ Sans\ Mono\ \for\ Powerline\ 9,DejaVu\ Sans\ Mono\ 9,\Monospace\ 9,Andale\ Mono\ Regular\ 9,Menlo\ Regular\ 9,Consolas\ Regular\ 9,Courier\ New\ Regular\ 10
            endif
            nnoremap <C-F9> :if &go=~#'m'<Bar>set go-=m<Bar>else<Bar>set go+=m<Bar>endif<CR>
        else
            if &term == 'xterm' || &term == 'screen'
                set t_Co=256 " Enable 256 colors to stop the CSApprox warning and make xterm vim shine
            endif
    "set term=builtin_ansi " Make arrow and other keys work
        endif
    " }


    set showmode " Display the current mode
    set cursorline " Highlight current line

    highlight clear SignColumn " SignColumn should match background
    highlight clear LineNr " Current line number row will have same background color in relative mode
    let g:CSApprox_hook_post = ['hi clear SignColumn']
"highlight clear CursorLineNr " Remove highlight color from current line number

" Broken down into easily includeable segments

    set whichwrap=b,s,h,l,<,>,[,] " Backspace and cursor keys wrap too
    " set foldenable " Auto fold code
    set list
    set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace

" }



" Formatting {

    set linespace=0                 " No extra spaces between rows
    set nu " Line numbers on
    set nowrap " Do not wrap long lines
    set autoindent " Indent at the same level of the previous line
    set shiftwidth=4 " Use indents of 4 spaces
    set expandtab " Tabs are spaces, not tabs
    set tabstop=4 " An indentation every four columns
    set softtabstop=4 " Let backspace delete indent
    set tabpagemax=15 " Only show 15 tabs
    set nojoinspaces " Prevents inserting two spaces after punctuation on a join (J)
    set splitright " Puts new vsplit windows to the right of the current
    set splitbelow " Puts new split windows to the bottom of the current
"set matchpairs+=<:> " Match, to be used with %
    set pastetoggle=<F12> " pastetoggle (sane indentation on pastes)
    autocmd BufNewFile,BufRead *.coffee set filetype=coffee
" }

" GUI Settings {
" Bundles {

    " Installed Bundles {
        Plugin 'majutsushi/tagbar'
        Plugin 'tpope/vim-fugitive'
        Plugin 'scrooloose/syntastic'
        Plugin 'kien/ctrlp.vim'
        Plugin 'unite.vim'
        Plugin 'scrooloose/nerdtree'
        Plugin 'rking/ag.vim'
        Plugin 'Shougo/neocomplcache'
        Plugin 'Shougo/neosnippet'
        Plugin 'honza/vim-snippets'
        Plugin 'bling/vim-airline'
        "Plugin 'spf13/PIV'
        Plugin 'todotxt.vim'
"        Plugin 'Shougo/vimproc.vim'
        Plugin 'dart-lang/dart-vim-plugin'
        Plugin 'elzr/vim-json'
        Plugin 'airblade/vim-gitgutter'
        Plugin 'tpope/vim-dispatch'
        Plugin 'pangloss/vim-javascript'
        Plugin 'godlygeek/tabular' "Needed by vim-markdown
        Plugin 'plasticboy/vim-markdown'
        Plugin 'digitaltoad/vim-jade'
        Plugin 'jszakmeister/vim-togglecursor'
    " }
        call vundle#end()

    " Configurations {
        " Tagbar {
            "if executable('ctags')
                nmap <F6> :TagbarToggle<CR>
                nnoremap <silent> <leader>tt :TagbarToggle<CR>
            "endif
        " }

        " NerdTREE {
            map <Leader>e :let NERDTreeQuitOnOpen = 1<bar>NERDTreeToggle<CR>:NERDTreeMirror<CR>
            map <Leader>f :NERDTreeFind<CR>
            map <F5> :let NERDTreeQuitOnOpen = 0<CR>:NERDTreeToggle<CR>
            map! <F5> <Esc>:let NERDTreeQuitOnOpen = 0<CR>:NERDTreeToggle<CR>

            let NERDTreeShowBookmarks=1
            let NERDTreeIgnore=['\.pyc','\.$', '\.\.$', '\~$', '\.swo$', '\.swp$', '\.git$', '\.hg$', '\.svn$', '\.bzr$', 'node_modules$[[dir]]', 'packages$[[dir]]', '.pub$[[dir]]']
            let NERDTreeChDirMode=2
            let NERDTreeQuitOnOpen=1
            let NERDTreeMouseMode=2
            let NERDTreeShowHidden=1
            let NERDTreeKeepTreeInNewTab=1
            let g:nerdtree_tabs_open_on_gui_startup=0
        " }

        " Unite {
        let g:unite_enable_start_insert=1
        if executable('ag')
            let g:unite_source_grep_command='ag'
            let g:unite_source_grep_default_opts= '--nogroup --nocolor -i
                \ --ignore .git
                \ --ignore .pub
                \ --ignore packages '
            let g:unite_source_grep_recursive_opt=''

            let g:unite_source_rec_async_command='ag --follow --nocolor
                \ --nogroup -g ""'

            let g:unite_source_file_async_command='ag --follow --nocolor
                \--nogroup -g ""'
        endif
        "}
        " CtrlP {
        "   Bundle 'kien/ctrlp.vim'

            nnoremap <leader>b :CtrlPBuffer<CR>
            nnoremap <leader>p :CtrlPMixed<CR>

            let g:ctrlp_working_path_mode = 'ra'
            let g:ctrlp_custom_ignore = {
                \ 'dir':  '\.git$\|\.hg$\|\.svn$\|node_modules$',
                \ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$' }
            if executable('ag')
                " Replace native grep with ag
                set grepprg=ag\ --nogroup\ --nocolor\ --column
                set grepformat=%f:%l:%c%m
                nmap <silent> <C-DOWN> :cnext<CR>
                nmap <silent> <C-UP> :cprevious<CR>
                " set ctrlp to use ag
                " let g:ctrlp_user_command = 'ag --nocolor -l -g "" %s'
                let g:ctrlp_user_command = 'ag --nocolor 
                    \ --ignore .git
                    \ --ignore .pub
                    \ --ignore packages
                    \-l -g "" %s'
                " let g:ctrlp_use_caching=0
                " let s:ctrlp_fallback = 'ag %s --nocolor -l -g ""'
            elseif executable('ack')
                let s:ctrlp_fallback = 'ack %s --nocolor -f'
            elseif has("win32")
                " On Windows use "dir" as fallback command.
                let s:ctrlp_fallback = 'dir %s /-n /b /s /a-d'
            endif
        " }

        "Syntastic {
            let g:syntastic_javascript_checkers=['jshint']
            " uncomment both to enable auto check on file save
            " let g:syntastic_enable_signs=1 
            " let g:syntastic_auto_loc_list=1
            let g:syntastic_check_on_open=0
            let g:syntastic_check_on_wq=0
            " let g:syntastic_always_populate_loc_list=1
            " Run dart analyzer on file
            " autocmd FileType dart set errorformat+=%.%#\\\|%.%#\\\|%.%#\\\|%f\\\|%l\\\|%c\\\|%.%#\\\|%m
            " set makeprg=dart_analyzer\ --enable_type_checks\ %\ 2>&1\ \\\|\ sed\ 's/file://'
            " autocmd FileType dart set makeprg=dartanalyzer\ --machine\ %
            " autocmd BufWritePre *.dart Make
            let g:syntastic_mode_map = {"mode" : "active",
                \ "passive_filetypes" : ["dart"] }
        "}
        " Fugitive {
            " nnoremap <silent> <leader>gs :Gstatus<CR>
            " nnoremap <silent> <leader>gd :Gdiff<CR>
            " nnoremap <silent> <leader>gc :Gcommit<CR>
            " nnoremap <silent> <leader>gb :Gblame<CR>
            " nnoremap <silent> <leader>gl :Glog<CR>
            " nnoremap <silent> <leader>gp :Git push<CR>
            " nnoremap <silent> <leader>gr :Gread<CR>
            " nnoremap <silent> <leader>gw :Gwrite<CR>
            " nnoremap <silent> <leader>ge :Gedit<CR>
            " nnoremap <silent> <leader>gi :Git add -p %<CR>
            " nnoremap <silent> <leader>gg :SignifyToggle<CR>
        " }
        " Airline {
            if has('gui_running')
                let g:airline_powerline_fonts=1
            else
                let g:airline_left_sep='›' " Slightly fancier than '>'
                let g:airline_right_sep='‹' " Slightly fancier than '<'
            endif
            let g:airline#extensions#tabline#enabled = 1
            " See `:echo g:airline_theme_map` for some more choices
            let g:airline_theme = 'dark'
        " }
        "Neocomplcache {
            let g:acp_enableAtStartup = 0   " Disable built in autocmplete
            let g:neocomplcache_enable_at_startup = 1 " use neocompl cache
            let g:neocomplcache_enable_cursor_hold_i = 1
            let g:neocomplcache_enable_ignore_case = 1 " ignore case...
            let g:neocomplcache_enable_smart_case = 1 " unless word starts by capital letter
            let g:neocomplcache_enable_auto_delimiter = 1 " Insert delimiter (parenthesis for functions, etc)
            " let g:neocomplcache_max_list = 20
            " let g:neocomplcache_force_overwrite_completefunc = 1
            let g:neocomplcache_auto_completion_start_length = 3
            let g:neocomplcache_enable_insert_char_pre = 1 " Prevent popup to display when moving using arrows
            " Define dictionary.
            let g:neocomplcache_dictionary_filetype_lists = {
                \ 'default' : '',
                \ 'vimshell' : $HOME.'/.vimshell_hist',
                \ 'scheme' : $HOME.'/.gosh_completions'
                \ }

            " Define keyword.
            if !exists('g:neocomplcache_keyword_patterns')
                let g:neocomplcache_keyword_patterns = {}
            endif
            let g:neocomplcache_keyword_patterns['default'] = '\h\w*'
            
            " Key Mappings
            " CR: select and close the popup
            inoremap <expr><CR> pumvisible() ? neocomplcache#close_popup() : "\<CR>"

            " Enable omni completion.
            autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
            autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
            autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
            autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
            autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
            autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
        " }

        " neosnippet (needs Nocomplcache) {
            let g:neosnippet#enable_snipmate_compatibility = 1 " Enable neosnippet snipmate compatibility mode
            let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets' " Use honza's snippets
            " Mappings
            " map <F7> :NeoComplCacheToggle<CR>
            imap <C-k> <Plug>(neosnippet_expand_or_jump)
            smap <C-k> <Plug>(neosnippet_expand_or_jump) 
            imap <expr><TAB> neosnippet#expandable_or_jumpable()?
                \ "\<Plug>(neosnippet_expand_or_jump)"
                \: pumvisible() ? "\<C-n>" : "\<TAB>"
            smap <expr><TAB> neosnippet#expandable_or_jumpable()?
                \ "\<Plug>(neosnippet_expand_or_jump)"
                \: "\<TAB>"
            " xmap <C-k> <Plug>(neosnippet_expand_target)
            " If selected is not a snippet, go to previous
            " imap <silent><expr><C-k> neosnippet#expandable() ?
            "        \ "\<Plug>(neosnippet_expand_or_jump)" : (pumvisible() ?
            "        \ "\<C-n>" : "\<Plug>(neosnippet_expand_or_jump)")
            " smap <TAB> <Right><Plug>(neosnippet_jump_or_expand)

            " For snippet_complete marker.
            if has('conceal')
                set conceallevel=2 concealcursor=i
            endif
        " }
        "
        " dart lang {
            let g:dart_style_guide = 1
        " set makeprg=$DART_SDK/bin/dart_analyzer\ --enable_type_checks\ %\ 2>&1\ \\\|\ sed\ 's/file://'
        " if has('vim_starting')
            " set nocompatible
            " set runtimepath+=~/.vim/bundle/dart-vim-plugin
            autocmd BufRead,BufNewFile,BufRead *.dart set filetype=dart
        "endif
        "filetype plugin indent on
        " }
        
        " Markdown {
            
        " }

    " }

" }
