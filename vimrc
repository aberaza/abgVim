" Helper Functions {
" Source config file only if it exists

" }

" HomeMade helper functions
source ~/.vim/abg.vim
" Environment {
set nocompatible " Must  line
if MAC()
  set shell=/usr/local/bin/zsh
elseif UNIXLIKE()
  set shell=/usr/bin/zsh
endif
" Local settings file
call SourceFile("~/.vim/local.vimrc")
" General Editor Config
call SourceFile("~/.vim/config/editor.vimrc")
" Bundles
call SourceFile("~/.vim/config/bundles.vimrc")
call SourceFile("~/.vim/config/bundlesConfig.vimrc")
if NEOVIM()
  luafile ~/.vim/config/vimrc.lua
endif
" UI
call SourceFile("~/.vim/config/ui.vimrc")
" KeyMappings
call SourceFile("~/.vim/config/keymaps.vimrc")
" Autocommands/Settings per file type
call SourceFile("~/.vim/config/autocmds.vimrc")
" Mouse Menu
call SourceFile("~/.vim/config/mousemenu.vimrc")
" }
