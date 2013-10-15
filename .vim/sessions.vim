let cmdline=split( system( "ps -o command= -p " . getpid() ) )
let g:seseq=index(cmdline, "-S")
let uname=expand("$USERNAME")
let g:sespath='~/.vim/sessions/'.uname.'-dev-session.vim'
fu! SaveSess()
    if g:seseq > 0
        execute 'mksession!'.g:sespath
    endif
endfunction

fu! RestoreSess()
    if g:seseq > 0
        call system('touch '.g:sespath)
        execute 'so'.g:sespath
    endif
endfunction

autocmd VimLeave * call SaveSess()
autocmd VimEnter * call RestoreSess()
