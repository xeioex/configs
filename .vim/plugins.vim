filetype plugin on
filetype plugin indent on

"vundle (plugin manager/updater)
filetype off  " required!

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" :scriptsname - shows all loaded plugins

"
" path to github or other repo for plugins
"

Plugin 'scrooloose/nerdtree'
" visualize changes as tree
Plugin 'sjl/gundo.vim'
"Plugin 'vim-scripts/GdbFromVim'
Plugin 'vim-scripts/ifdef-highlighting'
" switch between source and header files
Plugin 'derekwyatt/vim-fswitch'

" plugins runtime reload
Plugin 'xolox/vim-reload'
Plugin 'xolox/vim-misc'

Plugin 'xolox/vim-session'

" git wrapper
Plugin 'tpope/vim-fugitive'
" handling surrounds: example cs"' inside "phase inside quote" convert it to 'phrase inside quote'
Plugin 'tpope/vim-surround'
" Repeat.vim remaps . in a way that plugins can tap into it
Plugin 'tpope/vim-repeat'
" supercharged substitute command
" example 1:%S/{man,dog}/{dog,man}/g will replace man -> dog and dog -> man in
" one replace command
" :%S/facilit{y,ies}/building{,s}/g
Plugin 'tpope/vim-abolish'

" Mercurial wrapper
Plugin 'ludovicchabant/vim-lawrencium'

" camelCaseMotions
Plugin 'bkad/CamelCaseMotion'

" using ack instead of grep from vim
Plugin 'mileszs/ack.vim'

"  start searching from your project root instead of the cwd
let g:ag_working_path_mode="r"

" create a temporary scratch buffer to store
" and edit text that will be discarded when you quit/exit vim
Plugin 'vim-scripts/scratch.vim'
" aligning text
" example 1: Tabularize /,
"     Some short phrase,some other phrase
"     A much longer phrase here,and another long phrase
"
"     Some short phrase         , some other phrase
"     A much longer phrase here , and another long phrase
Plugin 'godlygeek/tabular'
" Buffer explorer
Plugin 'corntrace/bufexplorer'
" Syntastic is a syntax checking plugin that runs files through external
" syntax checkers and displays any resulting errors to the user. This can be
" done on demand, or automatically as files are saved
Plugin 'scrooloose/syntastic'
" using * for search for current visual selection
Plugin 'vim-scripts/visualstar.vim'
" populated arglist with quickfix list files
Plugin 'nelstrom/vim-qargs'
" Highlight matching parens in a rainbow of colors
Plugin 'kien/rainbow_parentheses.vim'

Plugin 'vim-scripts/functionlist.vim'

" Conveniently shows loaded bundles and plugins
"Plugin 'mbadran/headlights'

call vundle#end()             " required
filetype plugin indent on     " required!
