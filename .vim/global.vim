"path variable
set path+=.,,Headers,Sources,MLStreams/Sources/**,MLStreams/Headers/**,MLStreams/MLFoundation/Sources/**,MLStreams/MLFoundation/Headers/**,/usr/include/GNUstep/**

"temporarily
set makeprg=scons

"spaces number per \t
set tabstop=8
set shiftwidth=8
set softtabstop=8
set smarttab
"turn a tabs into spaces
set expandtab

"list chars
set listchars=tab:▸-,eol:¬,trail:@,nbsp:=

"wrap long strings
"set wrap

"autoindent for newlines
set ai
"C language style indents
set cin

"lazy screen redrawing
"set lz

set number
syntax on

set backspace=2

"underline current line
set cursorline

set laststatus=2   " show status line always
set statusline=%{SyntasticStatuslineFlag()}:%f%m%r%h%w\ %y\ enc:%{&enc}\ ff:%{&ff}\ fenc:%{&fenc}%=(ch:%3b\ hex:%2B)\ col:%2c\ line:%2l/%L\ [%2p%%]

"switchbuf
" Vim will jump to that window, instead of creating a new window
set switchbuf=useopen

set title

"backup dir list
set backupdir =~/.vim/backups,/tmp

"remember copy registers after quitting in the .viminfo file
set viminfo='100,\"1000
"remember undo after quitting

"allow switch from non-saved file
set hidden
set history=15000

set mouse=v

set backspace=indent,eol,start

set nrformats=

" search and regexp
nnoremap / /\v
"vnoremap / /\v

"default global (/g) option
set gdefault

"so changed buffers are automatically saved when switching to another buffer
set autowrite

" Highlights space at the end of a line
let c_space_errors = 1
