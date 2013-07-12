"===========
"   maps
"===========

inoremap <F1> <ESC>
vnoremap <F1> <ESC>

" after pastetoggle
set pastetoggle=<F2>
inoremap <silent> <C-u> <ESC>u:set paste<CR>.:set nopaste<CR>gi

nnoremap <F3> :set nonumber!<CR>

"Fuzzy files find
nnoremap <F4> :FufFile **/

"Gundo plugin toggle
nnoremap <F5> :GundoToggle<CR>

"list toggle (invisible character)
nnoremap <F6> :set list!<CR>

"Strip white spaces
nnoremap <F7> :call <SID>StripTrailingWhitespaces()<CR>

" turn on/off syntastic checker
nnoremap <F8> :SyntasticToggleMode<CR>

"=====leader(custom) maps=====
"prev tag
nnoremap <leader>e :tprev <CR>

"next tag
nnoremap <leader>r :tnext <CR>

"copen
nnoremap <leader>q :cp <CR>

"imap <C-n> <Esc> :cn <CR>i
"map <C-n> :cn <CR>
nnoremap <leader>w :cn <CR>

"buffer navigation
nnoremap <leader>s :bprevious <CR>
nnoremap <leader>d :bn <CR>

" increase/decrease number under cursor
" moved to avoid conflict with tmux's (C-a) shortcut
nnoremap <leader>z <C-x>
nnoremap <leader>x <C-a>

"quickly reload my ~/.vimrc file
nnoremap <leader>vr :source $MYVIMRC<cr>

