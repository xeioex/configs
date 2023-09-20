let g:session_autosave = 'no'
let g:session_autoload = 'no'
let uname = expand("$USER")
let g:session = tolower(uname . '-' . v:servername)

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

"fix me
"autocmd VimLeave * call SaveCurrentSession()
"autocmd VimEnter * call RestoreCurrentSession()
