let g:session_autosave = 'no'
let uname = expand("$USERNAME")
let g:session = uname . '-' . v:servername
fu! SaveCurrentSession()
    if exists("v:servername")
        execute ':SaveSession! ' . g:session
    endif
endfunction

fu! RestoreCurrentSession()
    if exists("v:servername")
        execute ':OpenSession! ' . g:session
    endif
endfunction

autocmd VimLeave * call SaveCurrentSession()
autocmd VimEnter * call RestoreCurrentSession()
