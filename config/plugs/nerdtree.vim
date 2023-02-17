if exists('g:plugs["nerdtree"]')
" NerdTREE {
  " let g:airline_powerline_fonts=1
  "let g:NERDTreeDirArrowExpandable = '' "'▸'       ﱮ
  "let g:NERDTreeDirArrowCollapsible = '' "'▾'
  let NERDTreeShowBookmarks=1
  let NERDTreeIgnore=['\.pyc','\.$', '\.\.$', '\~$', '\.swo$','\.swp$', '\.git$', '\.hg$', '\.svn$', '\.bzr$', 'node_modules$[[dir]]', 'build$[[dir]]', 'packages$[[dir]]', 'pub$[[dir]]']
  let NERDTreeRespectWildIgnore=1 "Respect wildingore setting
  let NERDTreeChDirMode=2
  let NERDTreeQuitOnOpen=1
  let NERDTreeMouseMode=2
  let NERDTreeShowHidden=0
  let NERDTreeKeepTreeInNewTab=1
  let NERDTreeStatusline=0
  let NERDTreeMinimalUI=1
  " highlight! link NERDTreeFlags NERDTreeDir
  " se supone que es para evitar colores raros
  " if exists('g:plugs["vim-devicons"]')
    let g:webdevicons_enable_nerdtree = 1
    let g:webdevicons_conceal_nerdtree_brackets = 1
    let g:NERDTreeHighlightFolders = 1
" endif
" }
endif

