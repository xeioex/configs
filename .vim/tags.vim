" rebuild tags file
nnoremap <F1> :!ctags --option=~/.vim/ctags-options<CR>
" rebuild tags upon buffer write
autocmd BufWritePost * call system("ctags --option=~/.vim/ctags-options")
