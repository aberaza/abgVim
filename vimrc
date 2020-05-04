" Helper Functions {
" Source config file only if it exists
silent function! SourceFile(file)
  if filereadable(expand(a:file))
    " echo "Sourcing " a:file
    exe 'source' a:file
  endif
endfunction

" Platform identification (from spf13-vim)
silent function! LINUX()
  return has('unix') && !has('macunix') && !has('win32unix')
endfunction
silent function! WINDOWS()
  return  (has('win16') || has('win32') || has('win64'))
endfunction
silent function! UNIXLIKE()
  return !WINDOWS()
endfunction
" }

" Environment {
set nocompatible " Must be first line
if UNIXLIKE()
  set shell=/bin/bash
endif

" }
" Todo: This should go into a local file, not here
if WINDOWS()
  cd ~/WORKSPACE
endif
" }

" Source Config {
" General Editor Config 
call SourceFile("~/.vim/config/vimrc.editor")
" Bundles 
call SourceFile("~/.vim/config/vimrc.bundles")
call SourceFile("~/.vim/config/vimrc.bundlesConfig")
" UI 
call SourceFile("~/.vim/config/vimrc.ui")
" KeyMappings 
call SourceFile("~/.vim/config/vimrc.keymaps")
" Autocommands/Settings per file type 
call SourceFile("~/.vim/config/vimrc.autocmds")
" Local settings file 
call SourceFile("~/.vim/vimrc.local")
" }

