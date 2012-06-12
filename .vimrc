"temporarily
set makeprg=scons

"spaces number per \t
set tabstop=8
set shiftwidth=8
set smarttab

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

"===========
"   maps
"===========

" after pastetoggle
set pastetoggle=<F2>
inoremap <silent> <C-u> <ESC>u:set paste<CR>.:set nopaste<CR>gi

nnoremap <F3> :set nonumber!<CR>

"new tab
imap <F4> <Esc>:browse tabnew<CR> 
map <F4> <Esc>:browse tabnew<CR>

"prev tab <F6>
imap <F5> <Esc> :tabprev <CR>i
map <F5> :tabprev <CR>

"next tab <F6>
imap <F6> <Esc> :tabnext <CR>i
map <F6> :tabnext <CR>

"prev tag
imap <F7> <Esc> :tprev <CR>i
map <F7> :tprev <CR>
"next tag
imap <F8> <Esc> :tnext <CR>i
map <F8> :tnext <CR>

"copen
imap <C-p> <Esc> :cp <CR>i
map <C-p> :cp <CR>
imap <C-n> <Esc> :cn <CR>i
map <C-n> :cn <CR>

"buffer
imap <C-K> <Esc> :bp <CR>i
map <C-K> :bp <CR>
imap <C-L> <Esc> :bn <CR>i
map <C-L> :bn <CR>


" increase/decrease number under cursor
" moved to avoid conflict with screen's (C-a) shortcut
nnoremap <C-o> <C-x>
nnoremap <C-p> <C-a>

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
command! -complete=file -nargs=* Egrep call s:RunShellCommand('egrep '.<q-args>)
command! -complete=file -nargs=* Gitk call s:RunShellCommand('gitk --all '.<q-args>)


" set syntax hightlight for certain file types
syntax on
filetype on
au BufNewFile,BufRead *.nu set filetype=lisp
au BufNewFile,BufRead *.plist set filetype=xml


"
set matchpairs+=<:>
set matchpairs+=[:]

