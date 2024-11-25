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
"
"
" Manage Keymaps
" Global dictionary to store registered keymaps
let g:abg_registered_keymaps = {}

function! abg#register_keys(mode, keys, command, ...) abort
    " Create a unique key for the entry
    let l:unique_key = a:mode . ':' . a:keys
    let l:extras = get(a:000, 0, {})

    " Store the keymap information in the global dictionary
    let g:abg_registered_keymaps[l:unique_key] = {
                \ 'mode': a:mode,
                \ 'command': a:command,
                \ 'keys': a:keys,
                \ 'extras': l:extras
                \ }
endfunction
function! abg#bind_keys() abort
    " Iterate over each registered keymap
    for l:keymap_key in keys(g:abg_registered_keymaps)
        let l:keymap = g:abg_registered_keymaps[l:keymap_key]

        let l:mode = l:keymap['mode']
        let l:keys = l:keymap['keys']
        let l:command = l:keymap['command']
        let l:extras = get(l:keymap, 'extras', {})


        if NEOVIM()
          let l:lua_extras = []
          for [l:key, l:value] in items(l:extras)
            if type(l:value) == type('')
              let l:value = '"' . substitute(l:value, '"', '\\"', 'g') . '"'
            endif
            call add(l:lua_extras, l:key . " = " . l:value)
          endfor
          " Merge extra options into a single Lua table
          let l:lua_extra_str = '{' . join(l:lua_extras, ', ') . '}'

          let l:lua_command = printf("vim.keymap.set('%s', '%s', '%s', %s)", l:mode, l:keys, l:command, l:lua_extra_str)

          execute 'lua ' l:lua_command
        else
          if l:mode == 'n'
              execute 'nnoremap' . l:keys . ' ' . l:command
          elseif l:mode == 'i'
              execute 'inoremap' l:keys l:command
          elseif l:mode == 'v'
              execute 'vnoremap' l:keys l:command
          elseif l:mode == 'x'
              execute 'xnoremap' l:keys l:command
          elseif l:mode == 'c'
              execute 'cnoremap' l:keys l:command
          elseif l:mode == 't'
              execute 'tnoremap' l:keys l:command
          else
              echoerr 'Unsupported mode: ' . l:mode
          endif
          if has_key(l:extras, 'desc')
            if exists('g:plugs["wim-which-key"]')
              call which_key#register(l:keys, {
                          \ 'mode': l:mode,
                          \ 'desc': l:extras['desc']
                          \ })
            endif
          endif
        endif
    endfor
endfunction

command -nargs=+ -bar KeyBind call abg#register_keys(<args>)
command -nargs=+ -bar NBind call abg#register_keys('n', <args>)
command -nargs=+ -bar IBind call abg#register_keys('i', <args>)
command -nargs=+ -bar VBind call abg#register_keys('v', <args>)
command -nargs=+ -bar XBind call abg#register_keys('x', <args>)
command -nargs=+ -bar CBind call abg#register_keys('c', <args>)
command -nargs=+ -bar TBind call abg#register_keys('t', <args>)
command -nargs=0 -bar BindApply call abg#bind_keys()



let g:quickfix_is_open = 0

function! abg#quickfix_toggle()
    if g:quickfix_is_open
        cclose
        let g:quickfix_is_open = 0
        execute g:quickfix_return_to_window . "wincmd w"
    else
        let g:quickfix_return_to_window = winnr()
        copen
        let g:quickfix_is_open = 1
    endif
endfunction
