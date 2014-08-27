"hint searching
set hls

"hint stuff
set showmatch
set hlsearch
set incsearch
set ignorecase
set smartcase

hi Normal ctermbg=darkgrey

" turn on/off highlight
nnoremap <leader><space> :noh<cr>

au Syntax lisp RainbowParenthesesLoadRound
au BufEnter *.lisp,*.lsp,*.l,*.nu,*.podsl RainbowParenthesesToggle
au BufLeave *.lisp,*.lsp,*.l,*.nu,*.podsl RainbowParenthesesToggle

let g:rbpt_loadcmd_toggle = 0
let g:rbpt_colorpairs = [
    \ ['magenta',     'purple1'],
    \ ['cyan',        'magenta1'],
    \ ['green',       'slateblue1'],
    \ ['yellow',      'cyan1'],
    \ ['red',         'springgreen1'],
    \ ['magenta',     'green1'],
    \ ['cyan',        'greenyellow'],
    \ ['green',       'yellow1'],
    \ ['yellow',      'orange1'],
    \ ]
let g:rbpt_max = 9
