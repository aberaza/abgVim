" from vim-plug wiki:
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle') " {
  " if !empty(filter(copy(g:plugs), '!isdirectory(v:val.dir)'))
  "   autocmd VimEnter * PlugInstall | q
  " endif
  " One config file autoload for each plugin!
  let g:plug_config_vim_dir = $HOME . '/.vim/config/plugs'
  let g:plug_config_lua_dir = $HOME . '/.vim/config/plugs'
  NPlug 'ouuan/vim-plug-config'

  " Dependencias y requisitos
  NPlug 'kyazdani42/nvim-web-devicons'
  NPlug 'nvim-lua/plenary.nvim'
  Plug 'ryanoasis/vim-devicons'
  Plug 'editorconfig/editorconfig-vim'

  " Mini.nvim 
  NPlug 'echasnovski/mini.nvim'

  " FileTree / Browse 
  NPlug 'nvim-tree/nvim-tree.lua'
  VPlug 'preservim/nerdtree'
  VPlug 'Xuyuanp/nerdtree-git-plugin'
  VPlug 'tiagofumo/vim-nerdtree-syntax-highlight' 
  VPlug 'tpope/vim-vinegar' 

  " Files and Buffer find
  " NPlug 'ibhagwan/fzf-lua', {'branch': 'main'}
  " NPlug 'nvim-telescope/telescope.nvim'
  " NPlug 'nvim-telescope/telescope-file-browser.nvim'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  " Debug 
  NPlug 'mfussenegger/nvim-dap'
  NPlug 'rcarriga/nvim-dap-ui' " Not needed but fancy to have UI for nvim-dap 
  NPlug 'theHamsta/nvim-dap-virtual-text'
  NPlug 'nvim-telescope/telescope-dap.nvim'
  " Testing / Units Test
  VPlug 'tpope/vim-dispatch' " Is recommended for vim-test
  Plug 'vim-test/vim-test'
  " Plug 'tpope/vim-projectionist'
  " Git
  Plug 'tpope/vim-fugitive'     " GIT integration
  Plug 'idanarye/vim-merginal'  " Fugitive plugin for branches 
  Plug 'mhinz/vim-signify'      " show changes in the file
  " Syntaxes & Indentations 
  " NPlug 'nvim-treesitter/nvim-treesitter' , {'do': ':TSUpdate'}  " We recommend updating the parsers on update
  NPlug 'ellisonleao/glow.nvim', { 'for': 'markdown' }
  NPlug 'iamcco/markdown-preview.nvim' 
  VPlug 'sheerun/vim-polyglot'
  " Plug 'lervag/vimtex', { 'for': 'tex' } "TeX LaTeX
  " Diagnostics show
  NPlug 'folke/trouble.nvim'
  " NPlug 'ten3roberts/qf.nvim'

  " NPlug 'ErichDonGubler/lsp_lines.nvim' 
  " Autocomplete 
  NPlug 'jose-elias-alvarez/typescript.nvim'
  NPlug 'neovim/nvim-lspconfig'
  NPlug 'hrsh7th/nvim-cmp'
  NPlug 'hrsh7th/cmp-nvim-lsp'
  NPlug 'hrsh7th/cmp-buffer'
  NPlug 'hrsh7th/cmp-path'
  NPlug 'hrsh7th/cmp-nvim-lsp-signature-help'
  NPlug 'hrsh7th/cmp-nvim-lua'
  NPlug 'jose-elias-alvarez/null-ls.nvim'
  VPlug 'dense-analysis/ale'
  " Snippets
  NPlug 'hrsh7th/cmp-vsnip'
  NPlug 'hrsh7th/vim-vsnip'

  " Themes & Colorschemes
  NPlug 'marko-cerovac/material.nvim'
  Plug 'sainnhe/sonokai'
  Plug 'sainnhe/gruvbox-material'
  Plug 'rafi/awesome-vim-colorschemes' " molokai/yo, minimalist, papercolor, solarized and many more
  Plug 'patstockwell/vim-monokai-tasty'
  Plug 'fxn/vim-monochrome'
  Plug 'Jorengarenar/vim-darkness'
  Plug 'kvrohit/rasmus.nvim'
  Plug 'andreypopp/vim-colors-plain'" una nota de azules ***
  Plug 'davidosomething/vim-colors-meh' " azules low contrast con más elementos,UI resaltados
  " UI Look & Feel
  Plug 'itchyny/lightline.vim'
  NPlug 'folke/which-key.nvim'
  " NPlug 'lukas-reineke/indent-blankline.nvim'
  VPlug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
  VPlug 'Yggdroot/indentLine'
  VPlug 'luochen1990/rainbow' " Colorize parenthesis
  VPlug 'tpope/vim-commentary' " Comentarios

  " REST Api as with postman/insomnia
  " Plug 'diepm/vim-rest-console'
  " Plug 'NTBBloodbath/rest.nvim', { 'on' : [ 'RestNvim', 'RestNvimPreview', 'RestNvimLast' ] }
  " Plug 'eliba2/vim-node-inspect'
call plug#end() " }
call plug#helptags()
