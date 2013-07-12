" set syntax hightlight for certain file types
syntax on
filetype on
au BufNewFile,BufRead *.nu set filetype=lisp
au BufNewFile,BufRead *.podsl set filetype=lisp
au BufNewFile,BufRead *.plist set filetype=xml
au BufNewFile,BufRead SCons* set filetype=python


" matchpairs
set matchpairs+=<:>
set matchpairs+=[:]
set matchpairs+=,:,

"JSON syntax hightlight
au! BufRead,BufNewFile *.json set filetype=json

augroup json_autocmd
autocmd!
autocmd FileType json set autoindent
autocmd FileType json set formatoptions=tcq2l
autocmd FileType json set textwidth=78 shiftwidth=2
autocmd FileType json set softtabstop=2 tabstop=8
autocmd FileType json set expandtab
autocmd FileType json set foldmethod=syntax
augroup END

" Syntax of these languages is fussy over bs Vs spaces
autocmd FileType make setlocal ts=8 sts=8 sw8 noexpandtab
autocmd FileType objc setlocal ts=8 sts=8 sw=8 expandtab
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" Customisations based on house-style (arbitrary)
autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType javascript setlocal ts=4 sts=4 sw=4 noexpandtab

" Treat .rss files as XML
autocmd BufNewFile,BufRead *.rss setfiletype xml
