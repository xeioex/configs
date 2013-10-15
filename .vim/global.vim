"path variable
set path+=.,,Headers,Sources,MLStreams/Sources/**,MLStreams/Headers/**,MLStreams/MLFoundation/Sources/**,MLStreams/MLFoundation/Headers/**,/usr/include/GNUstep/**

" UTF-8 is the only format
set encoding=utf-8

"temporarily
set makeprg=scons

"list chars
set listchars=tab:▸-,eol:¬,trail:@,nbsp:=

"autoindent for newlines
set ai
"C language style indents
set cin

set number
syntax on

set backspace=2

"underline current line
set cursorline

set laststatus=2   " show status line always
set statusline=%f%m%r%h%w\ %{fugitive#statusline()}\ %y\ enc:%{&enc}\ ff:%{&ff}%=(ch:%3b\ hex:%2B)\ col:%2c\ line:%2l/%L\ [%2p%%]\ indent:ts=%{&ts}\ sts=%{&sts}\ sw=%{&sw}\ et=%{&expandtab}

"switchbuf
" Vim will jump to that window, instead of creating a new window
set switchbuf=useopen

set title

"backup dir list
set backupdir=~/.vim/backups,/tmp
set directory=~/.vim/backups,/tmp


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

set foldmethod=manual

" Things to ignore
set wildignore=*~
set wildignore+=*vim/backups*
set wildignore+=build/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif,*.pdf
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
set wildignore+=*.o,*.out,*.obj,*.git,*.rbc,*.class,*.svn,*.gem
