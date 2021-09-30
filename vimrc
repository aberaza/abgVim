" Helper Functions {
" Source config file only if it exists
silent function! SourceFile(file)
  if filereadable(expand(a:file))
    " echo "Sourcing " a:file
    exe 'source' a:file
  endif
endfunction

" Platform identification (from spf13-vim)

silent function! MAC()
  return has('macunix')
endfunction
silent function! LINUX()
  return has('unix') && !has('macunix') && !has('win32unix')
endfunction
silent function! WINDOWS()
  return  (has('win16') || has('win32') || has('win64'))
endfunction
silent function! UNIXLIKE()
  return !WINDOWS()
endfunction

silent function! VIM()
  return !has('nvim')
endfunction
silent function! NEOVIM()
  return has('nvim')
endfunction
" }

" HomeMade helper functions
call SourceFile("~/.vim/abg.vim")
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


" Load local config and settings
call SourceFile("~/.vim/localconfig.vimrc")

" Variables por defecto para la configuración {
" Usar FZF o Ctrl-P ?
  let g:abg_use_fzf =  get(g:, 'abg_use_fzf', 0)

" Usar COC [solo con nvim] si no :(deoplete)
  let g:abg_use_coc = get(g:, 'abg_use_coc', 0) && has('nvim')

" Usar ALE Linter (prettier, eslint, etc)
  let g:abg_use_ale = get(g:, 'abg_use_ale', 1) || !g:abg_use_coc

" Fuente/Letra
  " let g:gui_font= get(g: 'gui_font', 'DejaVuSansMono Nerd Font Mono:h11')
" }



" Source Config {
" General Editor Config
call SourceFile("~/.vim/config/vimrc.editor")
" Bundles
call SourceFile("~/.vim/config/vimrc.bundles")
call SourceFile("~/.vim/config/vimrc.bundlesConfig")
call SourceFile("~/.vim/config/vimrc.lsp")
" UI
call SourceFile("~/.vim/config/vimrc.ui")
" KeyMappings
call SourceFile("~/.vim/config/vimrc.keymaps")
" Autocommands/Settings per file type
call SourceFile("~/.vim/config/vimrc.autocmds")
" Local settings file
call SourceFile("~/.vim/vimrc.local")
" }
