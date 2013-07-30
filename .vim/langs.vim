set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0
highlight lCursor guifg=NONE guibg=Cyan

function! KeyMapHighlight()
    if &iminsert == 0
        hi StatusLine ctermfg=DarkBlue guifg=DarkBlue
    else
        hi StatusLine ctermfg=white guifg=yellow
    endif
endfunction

au WinEnter * :call KeyMapHighlight()

cmap <silent> <leader>^ <C-^>
imap <silent> <leader>^ <C-^>X<Esc>:call KeyMapHighlight()<CR>a<C-H>
nmap <silent> <leader>^ a<C-^><Esc>:call KeyMapHighlight()<CR>
vmap <silent> <leader>^ <Esc>a<C-^><Esc>:call KeyMapHighlight()<CR>gv

