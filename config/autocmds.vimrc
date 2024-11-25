" CSS {
    " Enable omni completion.
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
" }

" HTML & Markdown {
    " Enable omni completion.
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType markdown setlocal wrap
    autocmd FileType markdown setlocal spell
    autocmd FileType markdown setlocal spelllang=es
" }

" LaTex {
    autocmd FileType tex setlocal wrap
    autocmd FileType tex setlocal spell
    autocmd FileType tex setlocal spelllang=es
" }

" IPYNB JupyterNotebook use Markdown syntax
    " autocmd BufNewFile,BufRead *.ipynb set syntax=markdown

" JavaScript {
    " Enable omni completion.
    " autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
" }
" Python {
    " Enable omni completion.
    " autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
" }
" XML {
    " Enable omni completion.
    " autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
" }
" Ruby {
    " Enable omni completion.
    " autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
" }

" json {
    " autocmd BufRead,BufNewFile *.json set filetype=json
" }

" qml {
    " autocmd BufRead,BufNewFile,BufRead *.qml set filetype=qml
" }

" coffee script {
    " autocmd BufNewFile,BufRead *.coffee set filetype=coffee
" }

" dart lang {
    " let g:dart_style_guide = 1
    " autocmd BufRead,BufNewFile,BufRead *.dart set filetype=dart
" }

" part as partial xml file {
    " autocmd BufRead,BufNewFile,BufRead *.xml set filetype=xml
" }

" http client {
    autocmd FileType http nnoremap <buffer> <C-j> :lua require'rest.nvim'.run(true)<CR>
    autocmd FileType http vnoremap <buffer> <C-j> :lua require'rest.nvim'.run(true)<CR>
    autocmd FileType http inoremap <buffer> <C-j> :lua require'rest.nvim'.run(true)<CR>
" }
" Nvim Reload File Fix {
if has('nvim')
    au FocusGained,BufWinEnter * checktime
endif
" }
"





