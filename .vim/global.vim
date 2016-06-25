" UTF-8 is the only format
set encoding=utf-8

"list chars
set listchars=tab:▸-,eol:¬,trail:@,nbsp:=

"autoindent for newlines
set ai

"C language style indents
set cin

set number
syntax on

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
"remember undo after quitting
set viminfo='100,\"1000

"allow switch from non-saved file
set hidden
set history=15000

set mouse=v

" put all yanks to system register
"set clipboard=unnamed,unnamedplus

set backspace=indent,eol,start

" search and regexp
nnoremap / /\v
"vnoremap / /\v

"default global (/g) option
set gdefault

"so changed buffers are automatically saved when switching to another buffer
set autowrite

" Highlights space at the end of a line
let c_space_errors = 1

"set foldmethod=manual
set foldmethod=indent
set foldlevel=20

"interactive shell on '!
set shell=/bin/bash\ --rcfile\ ~/.bash_profile

" Things to ignore
set wildignore=*~
set wildignore+=*vim/backups*
set wildignore+=build/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif,*.pdf
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
set wildignore+=*.o,*.out,*.obj,*.git,*.rbc,*.class,*.svn,*.gem

