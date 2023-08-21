silent function! SourceFile(file)
  if filereadable(expand(a:file))
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
silent function! MINI()
  return 0
endfunction
" }
" Variables Definitions {
" LSP / COC / Code Completion
  " let g:abg_use_lsp = get(g:, 'abg_use_lsp', 1) && NEOVIM()

let g:abg_fav_colorschemes = get(g:, 'abg_fav_colorschemes', [])
let g:abg_fav_lofi_colorschemes = get(g:, 'abg_fav_lofi_colorschemes',[])
let g:abg_theme_enable_italics = get(g:, 'abg_theme_enable_italics', 1)
let g:abg_theme_enable_bold = get(g:, 'abg_theme_enable_bold', 1)
let g:abg_theme_enable_underline = get(g:, 'abg_theme_enable_underline', 1)
" }
let abg_themeindex=0
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

silent function! abg#plug_condition(condition, ...)
  if a:0 < 1  
    return s:err('Invalid number of arguments (1..2)')
  endif
  if a:condition
    let opts = get(a:000, 0, {})
    if opts 
      call plug#(a:1, opts)
    else
      call plug#(a:1)
    endif
  endif
endfunction

command -nargs=+ -bar NPlug call abg#plug_condition(NEOVIM(), <args>)
command -nargs=+ -bar VPlug call abg#plug_condition(VIM(), <args>)
command -nargs=+ -bar CPlug call abg#plug_condition(<args>)
  
" silent function! abg#switch_lightline_colors(name)

