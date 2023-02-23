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
  " let g:gui_font= get(g: 'gui_font', 'DejaVuSansMono Nerd Font Mono:h11')
" }



" Source Config {
" General Editor Config
call SourceFile("~/.vim/config/vimrc.editor")
" Bundles
call SourceFile("~/.vim/config/vimrc.bundles")
call SourceFile("~/.vim/config/vimrc.bundlesConfig")
if NEOVIM()
  luafile ~/.vim/config/vimrc.lua
endif
" UI
call SourceFile("~/.vim/config/vimrc.ui")
" KeyMappings
call SourceFile("~/.vim/config/vimrc.keymaps")
" Autocommands/Settings per file type
call SourceFile("~/.vim/config/vimrc.autocmds")
" }
