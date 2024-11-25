" Some tweaks and extra settings for Gui (line nvim-qt)
" This file is loaded last
" execute 'Guifont ' . escape(get(g:, 'gui_font', 'Guifont DejaVuSansMono Nerd Font Mono:h7'), ' \')
let s:fontsize=12

function! AdjustFontSize(amount)
  let s:fontsize=s:fontsize+a:amount
  execute 'GuiFont!' .escape(get(g:, 'gui_font', 'Maple Mono:h'), ' \') . s:fontsize
endfunction

execute 'GuiFont ' .escape(get(g:, 'gui_font', 'Maple Mono:h'), ' \') . s:fontsize

noremap <C-ScrollWheelUp> :call AdjustFontSize(1)<CR>
noremap <C-ScrollWheelDown> :call AdjustFontSize(-1)<CR>

