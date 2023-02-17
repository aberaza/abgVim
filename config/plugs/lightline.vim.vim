" Powerfont Separators:                                       
if exists('g:plugs["lightline"]')
  let g:lightline = {
    \   'colorscheme' : 'material',
    \   'enable': { 'tabline': 1 },
    \   'separator': { 'left':'' ,'right':'' },
    \   'subseparator' : { 'left': '','right': '' },
    \   'tabline_separator' : { 'left' : '', 'right' : '' },
    \   'tabline_subseparator' : { 'left' : '', 'right' : 'R' },
    \   'active' : {
    \     'left' : [['mode', 'paste'], ['filetype', 'filename', 'modified'] ],
    \     'right': [['gitbranch'], ['fileformat']]
    \   },
    \   'component_function': {
    \     'fileformat': 'MyFileformat',
    \     'filetype': 'MyIconFileType',
    \     'gitbranch': 'MyGitBranch',
    \   },
    \   'mode_map': {
    \     'n' : ' N ',
    \     'i' : ' I ',
    \     'R' : ' R ',
    \     'v' : ' V ',
    \     'V' : ' VL',
    \     "\<C-v>": ' VB',
    \     'c' : ' C ',
    \     's' : ' S ',
    \     'S' : ' SL',
    \     "\<C-s>": ' SB',
    \     't': ' T ',
    \   },
    \ }
  " Some icons for file format:            גּ     者
  function! MyIconFileType()
    " return winwidth(0)>65 ? (strlen(&filetype) ? WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
    return winwidth(0)>20 ? (strlen(&filetype) ? WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
  endfunction

  function! MyIconFileformat()
    return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
  endfunction

  function! MyProgressFormat()
    " let l:spinner = { 0: ' ', 1: '▏', 2: '▏', 3: '▎', 4: '▍', 5:'▌', 6:'▋', 7: '▊', 8: '▉', 9: '█', 10: 'X', 'steps': 10 }
    let l:spinner = { 0: '▁', 1: '▃', 2: '▄', 3: '▅', 4: '▆', 5: '▇', 6: '█', 7: '█', 'steps': 7 } 
    let l:position = float2nr(floor(1.0 * l:spinner['steps'] * line('.') / line('$')))

    return l:spinner[l:position]
  endfunction
  function! MyGitBranch()
    return (' ' . MyProgressFormat() . '  ' . ' ' . FugitiveHead())
  endfunction
endif
