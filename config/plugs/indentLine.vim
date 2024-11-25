if exists('g:plugs["indentLine"]')
  let g:indentLine_setColors = 0 " conceal is overwritten with grey, to keep conceal color with current theme , disable italic
  let g:indentLine_char_list = ['|', '¦', '┆', '┊']
  " let g:indentLine_enabled = 0 " disabled by default
endif
