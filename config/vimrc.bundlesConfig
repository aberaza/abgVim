if VIM()
  " Load preferent plugins onfig
  so ~/abgVim/config/plugs/vim-which-key.vim
  " Load the rest 
  args ~/abgVim/config/plugs/*.vim
  argd **/vim-which-key.vim
  silent argdo so %
endif
" Vim-rest
let g:vrc_response_default_content_type = 'application/json'

let g:vim_monokai_tasty_italic = g:abg_theme_enable_italics
" Deeps-Space
let g:deepspace_italics = g:abg_theme_enable_italics
" gruvbox theme
if NEOVIM()
  set background=dark
  let g:gruvbox_material_foreground = 'original' " material, mix, original 
  let g:gruvbox_material_background = 'hard' " sofr, medium, hard 
  let g:gruvbox_material_better_performance = 1
  let g:gruvbox_material_enable_bold = g:abg_theme_enable_bold 
  let g:gruvbox_material_enable_italic = g:abg_theme_enable_italics 
  let g:gruvbox_material_diagnostic_line_highlight = 1
  let g:gruvbox_material_cursor = 'orange' " auto, red, orange, yellow, green, aqua, blue, purple
  let g:gruvbox_material_statusline_style = 'original' " default, mix, original
  " colorscheme gruvbox-material

  let g:sonokai_style = 'shusia'
  let g:sonokai_enable_italic= g:abg_theme_enable_italics 
  let g:sonokai_enable_bold = g:abg_theme_enable_bold
  let g:sonokai_cursor = 'orange' " auto, ...
  let g:sonokai_transparent_background = 0 " 0 1 o 2 (segun cuantas cosas queremos sean transparentes)
  let g:sonokai_better_performance = 1
  colorscheme sonokai 
else
  set background=dark
  colorscheme gruvbox
endif
"
let g:gruvbox_italic    = g:abg_theme_enable_italics
let g:gruvbox_bold      = g:abg_theme_enable_bold
let g:gruvbox_underline = g:abg_theme_enable_underline
let g:gruvbox_udercurl  = g:abg_theme_enable_underline
let g:gruvbox_contrast_dark = 'hard'

" monochrome_italic_comments
  let g:monochrome_italic_comments = g:abg_theme_enable_italics
" rasmus_bold_functions
  let g:rasmus_bold_functions = g:abg_theme_enable_bold
  let g:rasmus_variant = 'monochrome' " dark, monochrome ***
" one theme
let g:one_allow_italics = g:abg_theme_enable_italics
" space-vim-dark
" autocmd ColorScheme * if (g:colors_name ==? 'space-vim-dark') && (g:abg_theme_enable_italics >=? 1) | hi Comment cterm=italic | endif
" nice colorschemes: ayu (dark & light), deep-space (dark), carbonized-dark,
" molokayo, one, onedark, space-vim-dark, tender
let g:abg_fav_colorschemes += ['ayu', 'deep-space', 'carbonized-dark', 'molokayo', 'one', 'onedark', 'space-vim-dark', 'tender', 'gruvbox', 'purify', 'sonokai', 'OceanicNext', 'ron' ]
let g:abg_fav_lofi_colorschemes += ['monochrome', 'rasmus', '256_noir', 'habamax', 'iceberg', 'meh', 'paramount', 'plain', 'quiet', 'rakr' ]
" augroup abg#colorscheme
"   autocmd!
"   autocmd ColorScheme * :echo "ColorScheme::" .expand('<amatch>')
" augroup END
