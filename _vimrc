

" Environment {
"
    source $VIMRUNTIME/vimrc_example.vim
    source $VIMRUNTIME/mswin.vim
    behave mswin

    if has("multi_byte")
        " Windows cmd.exe still uses cp850. If Windows ever moved to
        " Powershell as the primary terminal, this would be utf-8
        set terggencoding=cp850
        " Let Vim use utf-8 internally, because many scripts require this
        set encoding=utf-8
        set fileencoding=utf-8
        " setglobal fileencoding=utf-8
        " Windows has traditionally used cp1252, so it's probably wise to
        " fallback into cp1252 instead of eg. iso-8859-15.
        " Newer Windows files might contain utf-8 or utf-16 LE so we might
        " want to try them first.
        " set fileencodings=ucs-bom,utf-8,utf-16le,cp1252,iso-8859-15
    endif
    cd D:\WORKSPACE
    let mapleader = ","


" }
"


set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

" General {


	" UI Enhancements {
        set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles,$HOME/.vim,~/.vim/bundle/vundle
		set showmode	" Show current mode
		set cursorline	"Highlight current line
    	set nu                          " Line numbers on
    	set showmatch                   " Show matching brackets/parenthesis
    	set incsearch                   " Find as you type search
    	set hlsearch                    " Highlight search terms
    	set winminheight=0              " Windows can be 0 line high
    	set list!
        set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
	" }

" }

" Bundles {
    "



        Bundle "mattn/emmet-vim"

        let g:user_emmet_leader_key = '<c-y>'
    "    let g:user_emmet_mode='n'    "only enable normal mode functions, or
    "    let g:user_emmet_mode='inv'  "enable all functions, which is equal to
    "    let g:user_emmet_mode='a'    "enable all function in all mode.
        let g:user_emmet_install_global = 0 " Enable only for html and css
        autocmd FileType html,css EmmetInstall
    " }

    " Neocmplcache {
        Bundle 'Shougo/neocomplcache'
        Bundle 'Shougo/neosnippet'
        Bundle 'honza/vim-snippets'

        let g:acp_enableAtStartup = 0   " Disable autocompl popup
        let g:neocomplcache_enable_cursor_hold_i = 1
        let g:neocomplcache_enable_at_startup = 1 " use neocompl cache
        " let g:neocomplcache_enable_camel_case_completion = 1 "heavy
        let g:neocomplcache_enable_smart_case = 1
        "let g:neocomplcache_enable_underbar_completion = 1 "heavy 
        let g:neocomplcache_enable_auto_delimiter = 1
        let g:neocomplcache_max_list = 20
        let g:neocomplcache_force_overwrite_completefunc = 1
        let g:neocomplcache_auto_completion_start_length = 2

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
        let g:neocomplcache_keyword_patterns._ = '\h\w*'
    " Plugin key-mappings {

        "iunmap <CR>
        " <ESC> takes you out of insert mode
        "inoremap <expr> <Esc>   pumvisible() ? "\<C-y>\<Esc>" : "\<Esc>"
        " <CR> accepts first, then sends the <CR>
        "inoremap <expr> <CR>    pumvisible() ? "\<C-y>\<CR>" : "\<CR>"
        " <Down> and <Up> cycle like <Tab> and <S-Tab>
        "inoremap <expr> <Down>  pumvisible() ? "\<C-n>" : "\<Down>"
        "inoremap <expr> <Up>    pumvisible() ? "\<C-p>" : "\<Up>"
        " Jump up and down the list
        "inoremap <expr> <C-d>   pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
        "inoremap <expr> <C-u>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"
        " else

        " plugin key mappings
        inoremap <expr><C-g> neocomplcache#undo_completion()
        inoremap <expr><C-l> neocomplcache#complete_common_string()
        inoremap <expr><CR> neocomplcache#complete_common_string()
        " <CR>: close popup
        " <s-CR>: close popup and save indent.
        inoremap <expr><s-CR> pumvisible() ? neocomplcache#close_popup()"\<CR>" : "\<CR>"
        inoremap <expr><CR> pumvisible() ? neocomplcache#close_popup() : "\<CR>"

        " <C-h>, <BS>: close popup and delete backword char.
        inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
        inoremap <expr><C-y> neocomplcache#close_popup()
        " endif

        " <TAB>: completion. (TAB moves trhoug results list)
        inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
        inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"
        " }

        " Enable omni completion.
        autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
        autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
        autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
        autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
        autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
        autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete

        " Enable heavy omni completion.
        "if !exists('g:neocomplcache_omni_patterns')
        "    let g:neocomplcache_omni_patterns = {}
        "endif
        "let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
        "let g:neocomplcache_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
        "let g:neocomplcache_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
    " }
    " Snippets {
        " Use honza's snippets.
        let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'
        let g:neosnippet#enable_snipmate_compatibility = 1 " Enable neosnippet snipmate compatibility mode

        map <F7> :NeoComplCacheToggle<CR>

        imap <C-k> <Plug>(neosnippet_expand_or_jump)
        smap <C-k> <Plug>(neosnippet_expand_or_jump)
        xmap <C-k> <Plug>(neosnippet_expand_target)


        imap <silent><expr><C-k> neosnippet#expandable() ?
                \ "\<Plug>(neosnippet_expand_or_jump)" : (pumvisible() ?
                \ "\<C-n>" : "\<Plug>(neosnippet_expand_or_jump)")
        smap <TAB> <Right><Plug>(neosnippet_jump_or_expand)

        " For snippet_complete marker.
        if has('conceal')
            set conceallevel=2 concealcursor=i
        endif

        " Disable the neosnippet preview candidate window
        " When enabled, there can be too much visual noise
        " especially when splits are used.
        set completeopt-=preview
    " }

    " Dart Language {
        Bundle 'dart-lang/dart-vim-plugin'
        au BufNewFile,BufRead *.dart set syn=dart
    " }
" }
