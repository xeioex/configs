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
au BufNewFile,BufRead SCons* set filetype=python
au BufNewFile,BufRead *.json set filetype=json

" per filetype custom setup
augroup json_autocmd
autocmd!
au FileType json set autoindent
au FileType json set formatoptions=tcq2l
au FileType json set foldmethod=syntax
augroup END
