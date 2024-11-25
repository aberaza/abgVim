if exists('g:plugs["vim-polyglot"]')
" POLYGLOT & Extra syntaxes
" pangloss / Vim-Javascript <polyglot> {
  let g:javascript_plugin_jsdoc   = 1   " JsDoc Enabled
  " Custom conceal chars:
  set conceallevel=0  " Disable conceal
  let g:javascript_conceal_null                 = "ø"
  let g:javascript_conceal_NaN                  = "ℕ"
  let g:javascript_conceal_function             = "ƒ"
  let g:javascript_conceal_this                 = "@"
  let g:javascript_conceal_return               = "⇚"
  let g:javascript_conceal_undefined            = "¿"
  let g:javascript_conceal_prototype            = "¶"
  let g:javascript_conceal_static               = "•"
  let g:javascript_conceal_super                = "Ω"
  let g:javascript_conceal_arrow_function       = "⇒"
  let g:javascript_conceal_noarg_arrow_function = "🞅"
  let g:javascript_conceal_underscore_arrow_function = "🞅"
" }
"  maxmellon / vim JSX pretty {
  let g:vim_jsx_pretty_disable_tsx = 1 " Disable JSX for TS (another script)
  let g:vim_jsx_pretty_colorful_config = 1 " colourful
"  }
endif
