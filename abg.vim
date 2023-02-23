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

let abg_themeindex=0

let g:abg_fav_colorschemes = []
let g:abg_fav_lofi_colorschemes = []
function! abg#rotate_colors(lofi)
  if lofi
    let g:abg_themeindex = (g:abg_themeindex +1) % len(g:abg_fav_lofi_colorschemes)
    call abg#switch_colors(g:abg_fav_lofi_colorschemes[g:abg_themeindex])
  else
    let g:abg_themeindex = (g:abg_themeindex +1) % len(g:abg_fav_colorschemes)
    call abg#switch_colors(g:abg_fav_colorschemes[g:abg_themeindex])
  endif
endfunction

silent function! abg#switch_colors(name)
  execute 'colorscheme' fnameescape(a:name)
  " silent execute 'doautocmd ColorScheme' fnameescape(a:name)
endfunction

silent function! abg#plug_neovim(name,...)
  if NEOVIM()
    call plug#(a:name)
  endif
endfunction
silent function! abg#plug_vim(name,...)
  if VIM()
    call plug#(a:name)
  endif
endfunction

command -nargs=+ -bar NPlug call abg#plug_neovim(<args>)
command -nargs=+ -bar VPlug call abg#plug_vim(<args>)
  
" silent function! abg#switch_lightline_colors(name)

