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

function! abg#plug_condition(condition, plugin_name, ...)
  if !a:condition
    return
  endif

  " echom 'Loading plugin' .. a:plugin_name
  function! s:load_modules(task)
    if empty(a:task)
      return
    endif

    if type(a:task) == v:t_list
      for t in a:task
        call plug#(t)
      endfor
    else
      call plug#(a:task)
    endif
  endfunction

  let opts = get(a:000, 0, {})
  " Handle 'requires' key in options, if exists
  let requires = get(opts, 'requires', '')
  call s:load_modules(requires)
  " Register the main plugin with the remaining options
  call plug#(a:plugin_name, opts)
   " Handle 'post' key in options, if exists
  let post = get(opts, 'post', '')
  call s:load_modules(post)
endfunction

command -nargs=+ -bar NPlug call abg#plug_condition(NEOVIM(), <args>)
command -nargs=+ -bar VPlug call abg#plug_condition(VIM(), <args>)
command -nargs=+ -bar APlug call abg#plug_condition(1, <args>)
command -nargs=+ -bar CPlug call abg#plug_condition(<args>)

function! abg#plug_load_config(package)
   let vimConfigPath = resolve(g:plug_config_vim_dir . "/" . a:package . ".vim")
   let luaConfigPath = resolve(g:plug_config_lua_dir . "/" . a:package . ".lua")
   let configDir = resolve("config/plugs/" . a:package)
  if filereadable(vimConfigPath)
    exec "source " . vimConfigPath
  elseif filereadable(luaConfigPath) 
    exec "source " . luaConfigPath
  else
    exec "runtime! " . configDir . "/**/*.{vim,lua}"
  endif
endfunction

function! abg#plug_config()
  for package in keys(g:plugs)
    if has_key(g:plugs[package], 'on') || has_key(g:plugs[package], 'for')
      execute 'autocmd User ' . package . ' call abg#plug_load_config("'. package . '")' 
      " execute 'autocmd User * echom "lazy package loaded"'
    else
      call abg#plug_load_config(package)
    endif
  endfor
endfunction

" function! on_load(name, exec)
"   if has_key(g:plugs[a:name], 'on') || has_key(g:plugs[a:name], 'for')
"     execute 'autocmd! User' a:name a:exec
"   else
"     execute 'autocmd VimEnter * call abg#plug_load_config(<sfile>)' 
"   endif
" endfunction
