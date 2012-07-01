set nocompatible
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
set listchars=tab:▸\ ,eol:¬


"wrap long strings
set wrap

"autoindent for newlines
set ai
"C language style indents
set cin

"hint stuff
set showmatch
set hlsearch
set incsearch
set ignorecase
set smartcase

" turnoff highlight
nnoremap <leader><space> :noh<cr>

"lazy screen redrawing
set lz

set number
syntax on

set backspace=2

set cursorline

set laststatus=2   " show status line always
set statusline=%f%m%r%h%w\ %y\ enc:%{&enc}\ ff:%{&ff}\ fenc:%{&fenc}%=(ch:%3b\ hex:%2B)\ col:%2c\ line:%2l/%L\ [%2p%%]

"hint searching
set hls

"path variable
set path+=Headers,Sources,MLStreams/Sources/,MLStreams/Headers/,MLStreams/MLFoundation/Sources/,MLStreams/MLFoundation/Headers/

hi Normal ctermbg=darkgrey

"switchbuf
" Vim will jump to that window, instead of creating a new window
set switchbuf=useopen

set title
set nobackup

"remember copy registers after quitting in the .viminfo file
set viminfo='100,\"1000
"remember undo after quitting

"allow switch from non-saved file
set hidden
set history=500

set mouse=v

set undofile
set backspace=indent,eol,start

" search and regexp
nnoremap / /\v
vnoremap / /\v

set gdefault

"===========
"   maps
"===========

inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" after pastetoggle
set pastetoggle=<F2>
inoremap <silent> <C-u> <ESC>u:set paste<CR>.:set nopaste<CR>gi

nnoremap <F3> :set nonumber!<CR>

"Nerdtree toggle
nnoremap <F4> :NERDTreeToggle <CR>

"Gundo plugin toggle
nnoremap <F5> :GundoToggle<CR>

"list toggle (invisible character)
nnoremap <F6> :set list!<CR>

"Strip white spaces
nnoremap <silent> <F7> :call <SID>StripTrailingWhitespaces()<CR>

"=====leader(custom) maps=====
"prev tag
"imap <F7> <Esc> :tprev <CR>i
"map <F7> :tprev <CR>
nnoremap <leader>e :tprev <CR>

"next tag
"imap <F8> <Esc> :tnext <CR>i
"map <F8> :tnext <CR>
nnoremap <leader>r :tnext <CR>

"copen
"imap <C-p> <Esc> :cp <CR>i
"map <C-p> :cp <CR>
nnoremap <leader>q :cp <CR>

"imap <C-n> <Esc> :cn <CR>i
"map <C-n> :cn <CR>
nnoremap <leader>w :cn <CR>

"buffer navigation
nnoremap <leader>s :bprevious <CR>
nnoremap <leader>d :bn <CR>

" increase/decrease number under cursor
" moved to avoid conflict with screen's (C-a) shortcut
nnoremap <leader>z <C-x>
nnoremap <leader>x <C-a>

"strip all trailing whitespace in the current file
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

"quickly open up my ~/.vimrc file in a vertically split
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>

"=========================================

"autocomplete by <Tab> for current active syntax
 function! InsertTabWrapper(direction)
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    elseif "backward" == a:direction
        return "\<c-p>"
    else
        return "\<c-n>"
    endif
 endfunction
 inoremap <tab> <c-r>=InsertTabWrapper ("forward")<cr>
 inoremap <s-tab> <c-r>=InsertTabWrapper ("backward")<cr>

 set langmap=ёйцукенгшщзхъфывапролджэячсмитьбюЁЙЦУКЕHГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ;`qwertyuiop[]asdfghjkl\\;'zxcvbnm\\,.~QWERTYUIOP{}ASDFGHJKL:\\"ZXCVBNM<>

 set wildmenu
 set wildignore=*.o,*.obj,*.bak,*.exe,*.py[co],*.swp,*~,*.pyc,.svn
 set wcm=<Tab>
 menu Encoding.koi8-r  :e ++enc=koi8-r<CR>
 menu Encoding.cp1251  :e ++enc=cp1251<CR>
 menu Encoding.cp866   :e ++enc=cp866<CR>
 menu Encoding.ucs-2le :e ++enc=ucs-2le<CR>
 menu Encoding.utf-8   :e ++enc=utf-8<CR>
 map <F12> :emenu Encoding.<Tab>


"Built-in shell in separate buffer

command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline)
	echo a:cmdline
	let expanded_cmdline = a:cmdline
	for part in split(a:cmdline, ' ')
	if part[0] =~ '\v[%#<]'
let expanded_part = fnameescape(expand(part))
	let expanded_cmdline = substitute(expanded_cmdline, part, expanded_part, '')
	endif
	endfor
	botright new
	setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
	call setline(1, 'You entered:    ' . a:cmdline)
	call setline(2, 'Expanded Form:  ' .expanded_cmdline)
	call setline(3,substitute(getline(2),'.','=','g'))
	execute '$read !'. expanded_cmdline
	setlocal nomodifiable
	1
endfunction

command! -complete=file -nargs=* Git call s:RunShellCommand('git '.<q-args>)
command! -complete=file -nargs=* Svn call s:RunShellCommand('svn '.<q-args>)
command! -complete=file -nargs=* Egrep call s:RunShellCommand('egrep '.<q-args>.' -RI ./')
command! -complete=file -nargs=* Mgrep call s:RunShellCommand('egrep '.<q-args>)
command! -complete=file -nargs=* Gitk call s:RunShellCommand('gitk --all '.<q-args>)


" set syntax hightlight for certain file types
syntax on
filetype on
au BufNewFile,BufRead *.nu set filetype=lisp
au BufNewFile,BufRead *.plist set filetype=xml


" matchpairs
set matchpairs+=<:>
set matchpairs+=[:]

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


" Stripwhitespace
function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction


"pathogen (runtime path manipulator)

filetype off

call pathogen#infect()
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

filetype plugin on
filetype plugin indent on

"vundle (plugin manager/updater)
filetype off  " required!

set rtp+=~/.vim/vundle.git/
call vundle#rc()

"path to github or other repo for plugins
Bundle 'L9'
Bundle 'tpope/vim-fugitive'
Bundle 'FuzzyFinder'
Bundle 'scrooloose/nerdtree'
Bundle 'sjl/gundo.vim'
Bundle 'vim-scripts/a.vim'
Bundle 'vim-scripts/GdbFromVim'
Bundle 'vim-scripts/JSON.vim'
Bundle 'jjgod/vim-cocoa'
Bundle 'vim-scripts/LanguageTool'
Bundle 'danchoi/goog'
Bundle 'xolox/vim-reload'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-repeat'
Bundle 'msanders/snipmate.vim'
Bundle 'sukima/xmledit'
Bundle 'bkad/CamelCaseMotion'
Bundle 'vim-scripts/Rainbow-Parenthesis'
Bundle 'xeioex/Conque-Shell'
Bundle 'mileszs/ack.vim'
Bundle 'vim-scripts/scratch.vim'
Bundle 'godlygeek/tabular'

" non github repos
Bundle 'git://git.wincent.com/command-t.git'

filetype plugin indent on     " required!


"Languagetool options
let g:languagetool_jar=$HOME . '/languagetool/LanguageTool.jar'
let g:languagetool_disable_rules='WHITESPACE_RULE,EN_QUOTES,UPPERCASE_SENTENCE_START,COMMA_PARENTHESIS_WHITESPACE'
