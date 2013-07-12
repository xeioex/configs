"spaces number per \t
set tabstop=8
set shiftwidth=8
set softtabstop=8
set smarttab
"turn a tabs into spaces
set expandtab

" Syntax of these languages is fussy over bs Vs spaces
au FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
au FileType objc setlocal ts=8 sts=8 sw=8 expandtab
au FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
au FileType json setlocal ts=8 sts=2 sw=2 expandtab

" Customisations based on house-style (arbitrary)
au FileType html setlocal ts=2 sts=2 sw=2 expandtab
au FileType css setlocal ts=2 sts=2 sw=2 expandtab
au FileType javascript setlocal ts=4 sts=4 sw=4 noexpandtab
