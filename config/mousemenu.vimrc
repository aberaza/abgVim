" Some spelling help
if has("spell")
  func s:SpellPopup()
    "Return early if no spell or spellang"
    if !&spell || &spelllang ==''
      return
    endif

    let current_column=col('.')
    let [w,a]=spellbadword()
    if w!=''
      if a=='caps'
        let s:suglist = [substitute(w, '.*', '\u&', '')]
      else
        let s:suglist = spellsuggest(w,10)
      endif

      if len(s:suglist) > 0
        let g:menutrans_spell_change_ARG_to = 'Cambia \ "%s"\ a'
        let s:changeitem = printf(g:menutrans_spell_change_ARG_to, escape(w, ' .'))
        let s:fromword = w
        let pri=1
        "set cpo to include <cr>"
        let cpo_save = &cpo
        set cpo&vim 
        for sug in s:suglist
          exe 'anoremenu 1.5.'. pri . ' PopUp.' . s:changeItem . '.' . excape(sug, ' .') . ' :call <SID>SpellRplace(' . pri .')<CR>'
          let pri += 1 
        endfor
      endif
    endif

  endfunction
endif


anoremenu PopUp.Code\ Actions <Cmd>:lua vim.lsp.buf.code_action()<cr>
anoremenu PopUp.Go\ to\ declaration <Cmd>:lua vim.lsp.buf.declaration()<cr>
anoremenu PopUp.Go\ to\ definition <Cmd>:lua vim.lsp.buf.definition()<cr>
anoremenu PopUp.Go\ to\ type\ definition <Cmd>:lua vim.lsp.buf.type_definition()<cr>
anoremenu PopUp.Go\ to\ implementation <Cmd>:lua vim.lsp.buf.implementation()<cr>
anoremenu PopUp.Go\ to\ definition <Cmd>:lua vim.lsp.buf.definition()<cr>
anoremenu PopUp.Go\ to\ definition <Cmd>:lua vim.lsp.buf.definition()<cr>
anoremenu PopUp.Rename\ Symbol <Cmd>:lua vim.lsp.buf.rename()<cr>
anoremenu PopUp.Format <Cmd>:lua vim.lsp.buf.format()<cr>

