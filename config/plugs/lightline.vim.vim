if exists('g:plugs["lightline.vim"]')
  set noshowmode
  " \   'colorscheme' : 'material',
  let g:lightline = {
    \   'colorscheme' : 'deus',
    \   'enable': { 'tabline': 1 },
    \   'separator': { 'left':'' ,'right':'' },
    \   'subseparator' : { 'left': '','right': '' },
    \   'active' : {
    \     'left' : [['mode', 'paste'], ['filename'], ['gitbranch']],
    \     'right': [['fileformat', 'filetype'],['lsp_info', 'lsp_hints', 'lsp_errors', 'lsp_warnings', 'lsp_ok', 'lsp_status']],
    \   },
    \   'inactive' : {
    \     'left': [['filename']],
    \     'right': []
    \   }, 
    \   'component_function': {
    \     'filename': 'MyFilename',
    \     'fileformat': 'MyIconFileformat',
    \     'filetype': 'MyIconFileType',
    \     'gitbranch': 'MyGitBranch',
    \     'percent': 'MyProgressFormat',
    \   },
    \}
    " \   'mode_map': {
    " \     'n' : ' N ',
    " \     'i' : ' I ',
    " \     'R' : ' R ',
    " \     'v' : ' V ',
    " \     'V' : ' VL',
    " \     "\<C-v>": ' VB',
    " \     'c' : ' C ',
    " \     's' : ' S ',
    " \     'S' : ' SL',
    " \     "\<C-s>": ' SB',
    " \     't': ' T ',
    " \   },
    " \ }

  " if false
  "   call add(g:lightline.active.right, [ 'diag_warnings', 'diag_hints', 'diag_infos', 'diag_ok'])

    " \   'component_expand' : {
    " \     'diag_errors': 'Diag_error',
    " \   },
    " \   'component_type': {
    " \     'diag_hints': 'right',
    " \     'diag_infos': 'right',
    " \     'diag_warnings': 'warning',
    " \     'diag_errors': 'error',
    " \     'diag_ok': 'right',
    " \   },
  " endif

  if exists('g:plugs["nvim-lightline-lsp"]') && NEOVIM() 
    call add(g:lightline.active.right, ['lsp_info', 'lsp_hints', 'lsp_errors', 'lsp_warnings', 'lsp_ok', 'lsp_status' ])
    let g:lightline.active.right =[ ['lsp_info', 'lsp_hints', 'lsp_errors', 'lsp_warnings', 'lsp_ok', 'lsp_status' ] ]
    call lightline#lsp#register()
    
    let g:lightline#lsp#indicator_hints   = '󰌵'
    let g:lightline#lsp#indicator_infos   = ''
    let g:lightline#lsp#indicator_warnings= ''
    let g:lightline#lsp#indicator_errors  = ''
    let g:lightline#lsp#indicator_ok      = "\uf00c"
  endif

  function! MyIconFileType()
    " return WebDevIconsGetFileTypeSymbol() . (winwidth(0)>65 ?  &filetype : '') 
    return WebDevIconsGetFileTypeSymbol() 
  endfunction

  function! MyFilename()
    let filename = expand('N:~:.') !=# '' ? expand('%:~:.') : '[None]'
    let modified = &modified? '': WebDevIconsGetFileTypeSymbol()
    return filename . ' ' . modified  
    " return filename
  endfunction

  function! MyIconFileformat()
    return winwidth(0) > 30 ?  WebDevIconsGetFileFormatSymbol() : ''
  endfunction

  function! MyProgressFormat()
    " let l:spinner = { 0: ' ', 1: '▏', 2: '▏', 3: '▎', 4: '▍', 5:'▌', 6:'▋', 7: '▊', 8: '▉', 9: '█', 10: 'X', 'steps': 10 }
    " let l:spinner = { 0: '▁', 1: '▃', 2: '▄', 3: '▅', 4: '▆', 5: '▇', 6: '█', 7: '█', 'steps': 7 } 
    let l:spinner = { 0: '█', 1: '▇', 2: '▆', 3: '▅', 4: '▄', 5: '▃', 6: '▁', 7: ' ', 'steps': 7 } 
    let l:position = float2nr(floor(1.0 * l:spinner['steps'] * line('.') / line('$')))
    return l:spinner[l:position]
  endfunction

  function! MyGitBranch()
    return ' ' . FugitiveHead()
  endfunction

   " function! MyDiagnostics()
   "   return Diag_info() . s:abg_diag_error() . s:abg_diag_warn() . s:abg_diag_hint()
   " endfunction

   " function! Diag_error()
   "   let errors = ''
   "   let errors_count = s:abg_get_diags('vim.diagnostic.severity.ERROR')
   "   return errors_count > 0 ? printf('%d', errors_count) : ''
   " endfunction

   " function! Diag_warn()
   "   let warns = ''
   "   let warns_count = s:abg_get_diags('vim.diagnostic.severity.WARN')
   "   return warns_count > 0 ? warns . warns_count : ''
   " endfunction

   " function! Diag_hint()
   "   let hints = ''
   "   let hints_count = s:abg_get_diags('vim.diagnostic.severity.HINT')
   "   return hints_count > 0 ? hints . hints_count : ''
   " endfunction

   " function! Diag_info()
   "   let infos = ''
   "   let infos_count = s:abg_get_diags('vim.diagnostic.severity.INFO')
   "   return infos_count > 0 ? infos . infos_count : ''
   " endfunction

   " function! s:abg_get_diags(dtype) abort
   "   if !s:abg_lsp_active()
   "     return 0
   "   endif
   "   return luaeval('vim.tbl_count(vim.diagnostic.get(0, { severity = ' . a:dtype . '}))')
   "   " return luaeval('vim.tbl_count(vim.diagnostic.get(' . bufnr() . ', { severity = ' . a:dtype . '}))')

   " endfunction


   " function! s:abg_lsp_active() abort
   "   " return !!luaeval('not vim.tbl_isempty(vim.lsp.buf_get_clients('.bufnr().'))')
   "   return !!luaeval('not vim.tbl_isempty(vim.lsp.buf_get_clients(0))')
   " endfunction

   " augroup lightline#diagnostic
   "  autocmd!
   "  autocmd DiagnosticChanged * call lightline#update()
   " augroup END
endif
