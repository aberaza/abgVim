" from vim-plug wiki:
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

let g:plug_config_vim_dir = $HOME . '/.vim/config/plugs'
let g:plug_config_lua_dir = $HOME . '/.vim/config/plugs'
call plug#begin('~/.vim/bundle') " {
  " Generic
  Plug 'editorconfig/editorconfig-vim'
  Plug 'liuchengxu/vista.vim'
  " Functionality for other plugins
  NPlug 'nvim-lua/plenary.nvim' 
  NPlug 'nvim-neotest/nvim-nio'
  NPlug 'andythigpen/nvim-coverage'
  " Files and Buffer find
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() }}
  " Plug 'junegunn/fzf.vim', { 'on': [ 'FZF', 'Files', 'GFiles', 'Buffers', 'Rg', 'Colors'] }
  Plug 'junegunn/fzf.vim'  
  " Mini.nvim 
  NPlug 'echasnovski/mini.nvim' 
  " FileTree / Browse 
  NPlug 'nvim-tree/nvim-tree.lua', { 'requires':  'nvim-tree/nvim-web-devicons' }
  " NPlug 'nvim-tree/nvim-tree.lua', { 'requires':  'nvim-tree/nvim-web-devicons', 'on': [ 'NvimTreeToggle', 'NvimTreeFocus'] }
  VPlug 'preservim/nerdtree', { 'requires':  'ryanoasis/vim-devicons', 'post' : [ 'Xuyuanp/nerdtree-git-plugin',  'tiagofumo/vim-nerdtree-syntax-highlight' ]}
  NPlug 'stevearc/aerial.nvim'
  " Syntaxes & Indentations 
  NPlug 'nvim-treesitter/nvim-treesitter' , { 'do': ':TSUpdate'}  " We recommend updating the parsers on update
  VPlug 'sheerun/vim-polyglot'
  " Testing / Units Test
  VPlug 'vim-test/vim-test', { 'requires' : 'tpope/vim-dispatch', 'on': [ 'TestNearest', 'TestFile', 'TestSuite', 'TestLast', 'TestVisit', 'Make'] }
  NPlug 'nvim-neotest/neotest', { 'requires': [ 'antoinemadec/FixCursorHold.nvim', 'nvim-treesitter/nvim-treesitter',  'nvim-neotest/nvim-nio',  'nvim-lua/plenary.nvim', 'https://github.com/Issafalcon/neotest-dotnet', 'nvim-neotest/neotest-jest' ] } 
  " Git
  Plug 'tpope/vim-fugitive', { 'post' : 'idanarye/vim-merginal' }    " GIT integration
  VPlug 'mhinz/vim-signify'      " show changes in the file
  NPlug 'lewis6991/gitsigns.nvim'
'
  " Diagnostics show
  NPlug 'folke/trouble.nvim'
  NPlug 'rachartier/tiny-inline-diagnostic.nvim'
  " Autocomplete & Snippets
  VPlug 'dense-analysis/ale'
  NPlug 'neovim/nvim-lspconfig', { 'requires':  ['williamboman/mason.nvim', 'williamboman/mason-lspconfig.nvim'] }
  NPlug 'L3MON4D3/LuaSnip', { 'tag': 'v2.*', 'do': 'make install_jsregexp', 'requires' : 'rafamadriz/friendly-snippets' }

  " NPlug 'Exafunction/codeium.nvim', { 'requires':  'nvim-lua/plenary.nvim' }
  NPlug 'zbirenbaum/copilot.lua'  " , { 'post' :   'zbirenbaum/copilot-cmp'} , { 'post': 'CopilotC-Nvim/CopilotChat.nvim' }

  NPlug 'olimorris/codecompanion.nvim', { 'requires': [ 'MeanderingProgrammer/render-markdown.nvim' ] }
  " NPlug 'yetone/avante.nvim', { 'branch': 'main', 'do': 'make', 'requires': [  'stevearc/dressing.nvim',  'nvim-lua/plenary.nvim',  'MunifTanjim/nui.nvim', 'HakonHarnes/img-clip.nvim']}
        " Deps
        " Plug 'stevearc/dressing.nvim'
        " Plug 'nvim-lua/plenary.nvim'
        " Plug 'MunifTanjim/nui.nvim'
        "
        " " Optional deps
        " Plug 'nvim-tree/nvim-web-devicons' "or Plug 'echasnovski/mini.icons'
        " Plug 'HakonHarnes/img-clip.nvim'
        " Plug 'zbirenbaum/copilot.lua'
        "
        " " Yay, pass source=true if you want to build from source
        " Plug 'yetone/avante.nvim', { 'branch': 'main', 'do': 'make' }


  NPlug 'hrsh7th/nvim-cmp', { 'requires': 'hrsh7th/cmp-vsnip',
        \'post': [
        \  'onsails/lspkind-nvim',
        \  'hrsh7th/cmp-nvim-lsp',
        \  'hrsh7th/cmp-buffer',
        \  'hrsh7th/cmp-path',
        \  'hrsh7th/cmp-nvim-lsp-signature-help',
        \  'jose-elias-alvarez/null-ls.nvim',
        \  'saadparwaiz1/cmp_luasnip',
        \]}
        " \  'zbirenbaum/copilot-cmp',


  " remote work
  NPlug 'amitds1997/remote-nvim.nvim', { 'requires': [ 'MunifTanjim/nui.nvim', 'nvim-telescope/telescope.nvim']}
   " Debug 
  NPlug 'mfussenegger/nvim-dap', { 'post' : [ 'rcarriga/nvim-dap-ui', 'theHamsta/nvim-dap-virtual-text' ] }
  NPlug 'mxsdev/nvim-dap-vscode-js', { 'requires': 'mfussenegger/nvim-dap', 'do': 'npm install --legacy-peer-deps @vscode/js-debug-browsers && npm update && npx gulp vsDebugServerBundle && mv dist out'}
  " NPlug 'nvim-telescope/telescope-dap.nvim'
  " Themes & Colorschemes
  NPlug 'marko-cerovac/material.nvim'
  Plug 'sainnhe/sonokai'
  Plug 'sainnhe/gruvbox-material'
  Plug 'rafi/awesome-vim-colorschemes' " molokai/yo, minimalist, papercolor, solarized and many more
  Plug 'patstockwell/vim-monokai-tasty'
  Plug 'andreypopp/vim-colors-plain' " una nota de azules ***
  Plug 'davidosomething/vim-colors-meh' " azules low contrast con más elementos,UI resaltados
  " UI Look & Feel
  VPlug 'itchyny/lightline.vim', { 'requires': 'ryanoasis/vim-devicons', 'post': 'josa42/nvim-lightline-lsp'}
  VPlug 'liuchengxu/vim-which-key'
  VPlug 'Yggdroot/indentLine'
  VPlug 'luochen1990/rainbow' " Colorize parenthesis
  VPlug 'tpope/vim-commentary' " Comentarios
  
  " Easier Working with native marks 
  Plug 'kshenoy/vim-signature'

  " Integration with kitty terminal 
  Plug 'knubie/vim-kitty-navigator', {'do': 'cp ./*.py ~/.config/kitty/'}

call plug#end() 
call plug#helptags()
call abg#plug_config()
