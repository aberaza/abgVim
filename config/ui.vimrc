" BasicEditorSettings{
if has('syntax')
  syntax on           " Enable syntax coloring. Set to enable to keep custom color changes
endif
set lazyredraw      " Don't update screen during macros
" }

" Lines {
set nowrap          " Do not wrap long lines
set breakindent     " Indent wrapped lines to match first line indentation
set cursorline      " Highlight current line ladder-, to toggle
set smartindent     " Smart line indentation
set number          " Line numbers on
" }

" Special Chars {
set list            " Show special chars nolist no prevent
set listchars=tab:→\ ,extends:›,precedes:‹,nbsp:␣,trail:• " Highlight whitespaces
set showbreak=↪\  " char to display on a wrapped line
if NEOVIM()
  set fillchars=vert:│,horiz:─,horizdown:┬,horizup:┴,verthoriz:┼,vertleft:┤,vertright:├,fold:-,eob:\ ,msgsep:‾ " make vertical lines look continuous, remove ~ from empty lines
  " "set fillchars=vert:│,horiz:─,horizdown:┬,horizup:┴,verthoriz:┼,vertleft:┤,vertright:├
  " set fillchars=vert:┃,horiz:━,horizdown:┳,horizup:┻,verthoriz:╋,vertleft:┫,vertright:┣ "bold 
  " set fillchars=vert: ,horiz: ,horizdown: ,horizup: ,verthoriz: ,vertleft: ,vertright: 
else
  set fillchars=vert:│,fold:- " make vertical lines look continuous, remove ~ from empty lines
endif 
" }

" Scroll and Mouse {
" "set mouse=v " Middle click pastes
set mouse=a " Automatically enable mouse usage
set mousehide " Hide the mouse cursor while typing
set scrolloff=4                 " Minimum lines to keep above and below cursor
set sidescrolloff=5             " Minimum cols to keep left and right from cursor
set scrolljump=5                " Lines to scroll when cursor leaves screen
" }

" Folding {
set foldenable                  " Auto fold code
set foldmethod=indent           " Folding method. One of indent, marker, manual, expr, syntax or diff
set foldlevelstart=99           " open all folds by defailt
set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo " Commands that trigger auto-unfold
" }

"Others
set showmatch               " Show matching brackets/parenthesis
set tabpagemax=15           " Only show 15 tabs
set showcmd                 " Show last command on bottom right
" }

" Windows & Panels {
set winminheight=0          " Windows can be 0 line high
set wildmenu                " Show list instead of just completing
" }

" Themes & Colors {
set t_Co=256 " Enable 256 colors to stop the CSApprox warning and make xterm vim shine
if(has("termguicolors"))
    set termguicolors
endif

if NEOVIM()
  " some transparency
  set pumblend=10
  set pumheight=20
  set winblend=10 

  set background=dark
"  let g:gruvbox_material_foreground = 'original' " material, mix, original 
"  let g:gruvbox_material_background = 'hard' " sofr, medium, hard 
"  let g:gruvbox_material_better_performance = 1
"  let g:gruvbox_material_enable_bold = 1 
"  let g:gruvbox_material_diagnostic_line_highlight = 1
"  let g:gruvbox_material_cursor = 'orange' " auto, red, orange, yellow, green, aqua, blue, purple
"  let g:gruvbox_material_statusline_style = 'original' " default, mix, original
  " colorscheme gruvbox-material

  let g:sonokai_style = 'shusia'
  let g:sonokai_enable_italic= 1 
  let g:sonokai_enable_bold = 1 
  let g:sonokai_cursor = 'orange' " auto, ...
  let g:sonokai_transparent_background = 0 " 0 1 o 2 (segun cuantas cosas queremos sean transparentes)
  let g:sonokai_better_performance = 1
  colorscheme sonokai 
else
  set background=dark
  colorscheme gruvbox
endif
" }

" GUI Vim (all) {
set linespace=0

if has('gui_running')
  set guioptions-=T   " Remove the toolbar
  set go-=L           " Hide left scrollbars
  set go-=l           " Hide left scrollbars
  set go-=R           " Hide right scrollbars
  set go-=r           " Hide right scrollbars
  set go+=e           " Native toolkit tabs
  set go-=m           " Remove top text menu
  set guioptions-=a   " For CTRL-V to work disable autoselect
  if has('win32') || has('win64')
    set guifont=DejaVuSansMono_Nerd_Font_Mono:h11,DejaVu_Sans_Mono_for_Powerline:h10 linespace=0                 " [No] Extra separation between rows
    " Use direct x for rendering
    set rop=type:directx,gamma:1.2,level:1.0,contrast:0.25,geom:1,taamode:1,renmode:5 " renmode:3 tambien va bien
    " nnoremap <F9> :set rop=type:directx,gamma:1.5,level:0.75,contrast:0.5;taamode:0;renmode:0<CR>
  else
    set guifont=DejaVuSansMono\ Nerd\ Font\ Mono\ 9,DejaVu\ Sans\ Mono\ \for\ Powerline\ 9,DejaVu\ Sans\ Mono\ 9 linespace=0
  endif
endif
" }
" vim:set ft=vim
