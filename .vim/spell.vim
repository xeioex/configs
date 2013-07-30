set spellfile=$HOME/.vim/spell/en.utf-8.add

let g:myLang = 0
let g:myLangList = ['nospell', 'en_us', 'ru_yo', 'en_us, ru_yo']
function! MySpellLang()
  "loop through languages
  if g:myLang == 0 | setlocal nospell | endif
  if g:myLang > 0 | let &l:spelllang = g:myLangList[g:myLang] | setlocal spell | endif
  echomsg 'language:' g:myLangList[g:myLang]
  let g:myLang = g:myLang + 1
  if g:myLang >= len(g:myLangList) | let g:myLang = 0 | endif
endfunction
