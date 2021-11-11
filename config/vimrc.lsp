" lua require("lsp_config")
:lua << EOF
  local nvim_lsp = require('lspconfig')

    nvim_lsp.tsserver.setup{}
    nvim_lsp.jsonls.setup{
      Commands = {
        Format = {
          function()
            vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})
          end
        }
      }
    }
    nvim_lsp.omnisharp.setup{}
    nvim_lsp.tsserver.setup{}
    nvim_lsp.vimls.setup{}
    nvim_lsp.elmls.setup{}
    nvim_lsp.gopls.setup {}



    require'lspsaga'.init_lsp_saga{
        error_sign = '',
        warn_sign = '',
        hint_sign = '',
        infor_sign = '',
        border_style = "round",
    }

    require'compe'.setup {
        enabled = true;
        autocomplete = true;
        debug = false;
        min_length = 1;
        preselect = 'enable';
        throttle_time = 80;
        source_timeout = 200;
        incomplete_delay = 400;
        max_abbr_width = 100;
        max_kind_width = 100;
        max_menu_width = 100;
        documentation = true;

        source = {
          path = true;
          nvim_lsp = true;
        };
    }

    nvim_lsp.diagnosticls.setup {
        -- on_attach = on_attach,
        filetypes = { 'javascript', 'javascriptreact', 'json', 'typescript', 'typescriptreact', 'css', 'less', 'scss', 'markdown', 'pandoc' },
        init_options = {
            linters = {
                eslint = {
                    sourceName = 'eslint_d',
                    command = 'eslint_d',
                    rootPatterns = { '.git', ".eslintrc",".eslintrc.json"  },
                    debounce = 100,
                    args = { '--stdin', '--stdin-filename', '%filepath', '--format', 'json' },
                    parseJson = {
                        errorsRoot = '[0].messages',
                        line = 'line',
                        column = 'column',
                        endLine = 'endLine',
                        endColumn = 'endColumn',
                        message = '[eslint] ${message} [${ruleId}]',
                        security = 'severity'
                    },
                    securities = {
                        [2] = 'error',
                        [1] = 'warning'
                    }
                },
            },
            filetypes = {
                javascript = 'eslint',
                javascriptreact = 'eslint',
                typescript = 'eslint',
                typescriptreact = 'eslint',
            },
            formatters = {
                eslint_d = {
                    command = 'eslint_d',
                    args = { '--stdin', '--stdin-filename', '%filename', '--fix-to-stdout' },
                    rootPatterns = { '.git' },
                },
                prettier = {
                    command = 'prettier',
                    args = { '--stdin-filepath', '%filename' }
                }
            },
            formatFiletypes = {
                css = 'prettier',
                javascript = 'eslint_d',
                javascriptreact = 'eslint_d',
                json = 'prettier',
                scss = 'prettier',
                less = 'prettier',
                typescript = 'eslint_d',
                typescriptreact = 'eslint_d',
                json = 'prettier',
                markdown = 'prettier',
            }
        }
    }

EOF
set completeopt-=preview
"use omni comletion from lsp
autocmd Filetype python setlocal omnifunc=v:lua.vim.lsp.omnifunc
"KEYS {
"Go To keys
nnoremap <silent> gd <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
" Actions and menus
nnoremap <silent><leader>ca :Lspsaga code_action<CR>
vnoremap <silent><leader>ca :<C-U>Lspsaga range_code_action<CR>
nnoremap <silent><leader>cc :Lspsaga show_line_diagnostics<CR>
"Hints and doc
" nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent>K :Lspsaga hover_doc<CR> 
nnoremap <silent>cs :Lspsaga signature_help<CR>
nnoremap <silent><leader>cs :Lspsaga signature_help<CR>
nnoremap <silent>cd :Lspsaga preview_definition<CR>
nnoremap <silent><leader>cd :Lspsaga preview_definition<CR>
"find references and definition of method/variable under cursor
nnoremap <silent>ch <Cmd>Lspsaga lsp_finder<CR> 
nnoremap <silent><leader>ch <Cmd>Lspsaga lsp_finder<CR> 

" Other functionality
" rename
nnoremap <silent>cr :Lspsaga rename<CR>
nnoremap <silent><leader>cr :Lspsaga rename<CR>
" scrolling inside popup
nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>
nnoremap <silent> [e :Lspsaga diagnostic_jump_next<CR>
nnoremap <silent> ]e :Lspsaga diagnostic_jump_prev<CR>


nnoremap <silent> <leader>E <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
nnoremap <silent> <leader>q <cmd>lua vim.lsp.diagnostic.set_loclist()<CR>
" nnoremap <space>ca <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
