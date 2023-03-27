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
call SourceFile("~/.vim/vimrc.local")
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
