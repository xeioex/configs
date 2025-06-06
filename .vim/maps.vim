inoremap <F1> <ESC>
vnoremap <F1> <ESC>

" number toggle
nnoremap <F3> :set nonumber!<CR>

" Fuzzy files find
nnoremap <F4> :FufFile **/

" Gundo plugin toggle
nnoremap <F5> :GundoToggle<CR>

" list toggle (invisible character)
nnoremap <F6> :set list!<CR>

" Strip white spaces
nnoremap <F7> :call StripTrailingWhitespaces()<CR>

" turn on/off syntastic checker
nnoremap <F8> :SyntasticToggleMode<CR>

" toggle spell
nnoremap <F9> :<C-U>call MySpellLang()<CR>

" toggle spell
nnoremap <F10> :set iminsert!<CR> :set imsearch!<CR>

"=====leader(custom) maps=====
" prev tag
nnoremap <leader>e :tprev <CR>

" next tag
nnoremap <leader>r :tnext <CR>

" copen prev
nnoremap <leader>q :cp <CR>
nnoremap <leader>w :cn <CR>

"buffer navigation
nnoremap <leader>s :bprevious <CR>
nnoremap <leader>d :bn <CR>

" increase/decrease number under cursor
" moved to avoid conflict with tmux's (C-a) shortcut
nnoremap <leader>z <C-x>
nnoremap <leader>x <C-a>

" quickly reload my ~/.vimrc file
nnoremap <leader>vr :source $MYVIMRC<cr>

" search word under cursor using ag
noremap <Leader>a :Ack <cword><cr>
noremap <Leader>A :Ack <cWORD><cr>

" open file's directory
noremap <Leader>d :e %:h<cr>

" file history
noremap <Leader>fh :Git lg %<cr>

" paste current file to paste.*.cc
noremap <Leader>p :!puc %<CR>

" Allow saving of files as sudo
cmap w!! w !sudo tee > /dev/null %
