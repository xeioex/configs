let g:session_autosave = 'no'
let g:session_autoload = 'no'
let uname = expand("$USERNAME")
let g:session = uname . '-' . v:servername
fu! SaveCurrentSession()
    if v:servername != ''
        execute ':SaveSession! ' . g:session
    endif
endfunction

fu! RestoreCurrentSession()
    if v:servername != ''
        execute ':OpenSession! ' . g:session
    endif
endfunction

autocmd VimLeave * call SaveCurrentSession()
autocmd VimEnter * call RestoreCurrentSession()
