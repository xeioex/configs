" rebuild tags file
nnoremap <F1> :!ctags --options=$HOME/.vim/ctags-options<CR>
" rebuild tags upon buffer write
"autocmd BufWritePost * call system("ctags --options=$HOME/.vim/ctags-options")
