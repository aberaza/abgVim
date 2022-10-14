" Helper Functions {
" Source config file only if it exists
silent function! SourceFile(file)
  if filereadable(expand(a:file))
    " echo "Sourcing " a:file
    exe 'source' a:file
  endif
endfunction

" HomeMade helper functions
call SourceFile("~/.vim/abg.vim")
" }

" Environment {
set nocompatible " Must  line
if UNIXLIKE()
  set shell=/usr/bin/zsh
endif


" Local settings file
call SourceFile("~/.vim/vimrc.local")
" Configuration and flags should be put there
" Variables por defecto para la configuración {
" Usar FZF o Ctrl-P ?
  let g:abg_use_fzf =  get(g:, 'abg_use_fzf', 1)
  let g:abg_use_ctrlp = get(g:, 'abg_use_ctrlp', 0)
" LSP / COC / Code Completion
  let g:abg_use_lsp = get(g:, 'abg_use_lsp', 1) && NEOVIM()
  let g:abg_use_coc = get(g:, 'abg_use_coc', 0) && NEOVIM()
" Usar ALE Linter (prettier, eslint, etc) 
  let g:abg_use_ale = get(g:, 'abg_use_ale', 0) || !g:abg_use_coc || !g:abg_use_lsp
" Fuente/Letra
  " let g:gui_font= get(g: 'gui_font', 'DejaVuSansMono Nerd Font Mono:h11')
" }



" Source Config {
" General Editor Config
call SourceFile("~/.vim/config/vimrc.editor")
" Bundles
call SourceFile("~/.vim/config/vimrc.bundles")
call SourceFile("~/.vim/config/vimrc.bundlesConfig")
if NEOVIM()
  call SourceFile("~/.vim/config/vimrc.lsp")
endif
" UI
call SourceFile("~/.vim/config/vimrc.ui")
" KeyMappings
call SourceFile("~/.vim/config/vimrc.keymaps")
" Autocommands/Settings per file type
call SourceFile("~/.vim/config/vimrc.autocmds")
" }
