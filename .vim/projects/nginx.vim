" default
set makeprg=make

au BufRead /tmp/mutt-* set tw=72
au BufRead /tmp/hg-editor-* set tw=72

" indent
set tabstop=4
set shiftwidth=4
set softtabstop=4
au FileType c,objc setlocal cinoptions=l1,:0,(0 ts=4 sts=4 sw=4 expandtab

au FileType perl setlocal ts=4 sts=4 sw=4 noexpandtab
