fu! SaveSess()
    execute 'mksession! ~/.vim/dev-session.vim'
endfunction

fu! RestoreSess()
execute 'so ~/.vim/dev-session.vim'
endfunction

autocmd VimLeave * call SaveSess()
autocmd VimEnter * call RestoreSess()
