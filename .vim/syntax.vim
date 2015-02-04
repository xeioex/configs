syntax on
filetype on

set matchpairs+=<:>
set matchpairs+=[:]
set matchpairs+=,:,

" set syntax hightlight for certain file types
au BufNewFile,BufRead *.nu set filetype=lisp
au BufNewFile,BufRead *.podsl set filetype=lisp

au BufNewFile,BufRead *.plist set filetype=xml
au BufNewFile,BufRead *.rss set filetype=xml
au BufNewFile,BufRead *.py set filetype=python
au BufNewFile,BufRead SCons* set filetype=python
au BufNewFile,BufRead *.json set filetype=json
au BufNewFile,BufRead *.t set filetype=perl

au BufRead /tmp/mutt-* set tw=72

" per filetype custom setup
augroup json_autocmd
autocmd!
au FileType json set autoindent
au FileType json set formatoptions=tcq2l
au FileType json set foldmethod=syntax
augroup END

au BufRead,BufNewFile *.wiki                set filetype=mediawiki
au BufRead,BufNewFile *.wikipedia.org*      set filetype=mediawiki
au BufRead,BufNewFile *.wikibooks.org*      set filetype=mediawiki
au BufRead,BufNewFile *.wikimedia.org*      set filetype=mediawiki
au BufRead,BufNewFile *wiki.undev*          set filetype=mediawiki
