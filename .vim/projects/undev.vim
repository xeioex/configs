"path variable
set path+=.,Headers,Sources,MLStreams/Sources/**,MLStreams/Headers/**,MLStreams/MLFoundation/Sources/**,MLStreams/MLFoundation/Headers/**
set path-=/usr/include

" default
set makeprg=scons

" indent
set tabstop=8
set shiftwidth=8
set softtabstop=8
au FileType c,objc setlocal cinoptions=l1,:0,(0 ts=8 sts=8 sw=8 expandtab
