"spaces number per \t
set tabstop=4
set shiftwidth=4
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
