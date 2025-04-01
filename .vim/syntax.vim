syntax on
filetype on

" set syntax hightlight for certain file types
au BufNewFile,BufRead *.nu set filetype=lisp
au BufNewFile,BufRead *.podsl set filetype=lisp

au BufNewFile,BufRead *.plist set filetype=xml
au BufNewFile,BufRead *.py set filetype=python
au BufNewFile,BufRead SCons* set filetype=python
au BufNewFile,BufRead *.json set filetype=json
au BufNewFile,BufRead *.t set filetype=perl
au BufNewFile,BufRead *.njs set filetype=javascript
au BufNewFile,BufNewFile *.gcov setfiletype gcov
au BufNewFile,BufRead *.plt,*.gnuplot setf gnuplot

" per filetype custom setup
augroup json_autocmd
autocmd!
au FileType json set autoindent
au FileType json set formatoptions=tcq2l
au FileType json set foldmethod=syntax
augroup END

source ~/.vim/syntax/gcov.vim
