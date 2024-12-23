local o, opt = vim.o, vim.opt
local indent = 2

-- Mostly from mini.nvim basics.lua
-- General
opt.undofile = true -- Enable persistent undo (see also `:h undodir`)
o.backup      = false -- Don't store backup while overwriting the file
o.writebackup = false -- Don't store backup while overwriting the file
opt.mouse = "a" -- Enable mouse for all available modes
vim.cmd('filetype plugin indent on') -- Enable all filetype plugins
opt.clipboard = "unnamedplus" -- Use system clipboard

-- Appearance
o.breakindent   = true    -- Indent wrapped lines to match line start
o.cursorline    = true    -- Highlight current line
o.linebreak     = true    -- Wrap long lines at 'breakat' (if 'wrap' is set)
o.number        = true    -- Show line numbers
o.splitbelow    = true    -- Horizontal splits will be below
o.splitright    = true    -- Vertical splits will be to the right

o.ruler         = false   -- Don't show cursor position in command line
o.showmode      = false   -- Don't show mode in command line
o.wrap          = false   -- Display long lines as just one line

o.signcolumn    = 'yes'   -- Always show sign column (otherwise it will shift text)
-- o.fillchars     = 'eob: ' -- Don't show `~` outside of buffer
opt.fillchars = { 
  eob = " ",
  fold = " ",
  foldopen = "",
  foldclose = "",
  diff = "╱",
}
-- Editing
o.ignorecase  = true -- Ignore case when searching (use `\C` to force not doing that)
o.incsearch   = true -- Show search results while typing
o.infercase   = true -- Infer letter cases for a richer built-in keyword completion
o.smartcase   = true -- Don't ignore case when searching if pattern has upper case
o.smartindent = true -- Make indenting smart
o.completeopt   = 'menuone,noinsert,noselect' -- Customize completions
o.virtualedit   = 'block'                     -- Allow going past the end of line in visual block mode
o.formatoptions = 'qjl1'                      -- Don't autoformat comments
-- o.formatoptions = "jcroqlnt"
opt.splitkeep = "screen"
o.shortmess = "filnxtToOFWIcC"
o.termguicolors = true -- Enable gui colors

-- Some opinioneted extra UI options
o.pumblend  = 10 -- Make builtin completion menus slightly transparent
o.pumheight = 10 -- Make popup menu smaller
o.winblend  = 10 -- Make floating windows slightly transparent
o.listchars = 'tab:> ,extends:…,precedes:…,nbsp:␣' -- Define which helper symbols to show
o.list      = true                                 -- Show some helper symbols

-- Enable syntax highlighting if it wasn't already (as it is time consuming)
if vim.fn.exists("syntax_on") ~= 1 then vim.cmd([[syntax enable]]) end

-- From Medium
opt.cmdheight = 0
opt.conceallevel = 3 -- set to 0 to disable conceal
opt.confirm = true
opt.expandtab = true
opt.hidden = true
opt.hlsearch = false
opt.inccommand = "nosplit"
opt.joinspaces = false
opt.laststatus = 0
-- opt.relativenumber = true
opt.scrolloff = 8
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
opt.shiftround = true
opt.shiftwidth = indent
opt.sidescrolloff = 8
opt.tabstop = indent
opt.termguicolors = true
opt.timeoutlen = 500 -- Key sequence timeout
opt.updatetime = 300
opt.wildmode = "longest:full,full"
