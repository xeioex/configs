call plug#begin()

Plug 'gmarik/Vundle.vim'

" :scriptsname - shows all loaded plugins

"
" path to github or other repo for plugins
"

Plug 'scrooloose/nerdtree'
" visualize changes as tree
Plug 'sjl/gundo.vim'
"Plugin 'vim-scripts/GdbFromVim'
Plug 'vim-scripts/ifdef-highlighting'
" switch between source and header files
Plug 'derekwyatt/vim-fswitch'

" plugins runtime reload
Plug 'xolox/vim-reload'
Plug 'xolox/vim-misc'

Plug 'xolox/vim-session'

Plug 'tpope/vim-fugitive'
" handling surrounds: example cs"' inside "phase inside quote" convert it to 'phrase inside quote'
Plug 'tpope/vim-surround'
" Repeat.vim remaps . in a way that plugins can tap into it
Plug 'tpope/vim-repeat'

" using ack instead of grep from vim
Plug 'mileszs/ack.vim'

"  start searching from your project root instead of the cwd
let g:ag_working_path_mode="r"

" create a temporary scratch buffer to store
" and edit text that will be discarded when you quit/exit vim
Plug 'vim-scripts/scratch.vim'

" Buffer explorer
Plug 'corntrace/bufexplorer'
" Syntastic is a syntax checking plugin that runs files through external
" syntax checkers and displays any resulting errors to the user. This can be
" done on demand, or automatically as files are saved
Plug 'scrooloose/syntastic'
" using * for search for current visual selection
Plug 'vim-scripts/visualstar.vim'
" populated arglist with quickfix list files
Plug 'nelstrom/vim-qargs'
" Highlight matching parens in a rainbow of colors
Plug 'kien/rainbow_parentheses.vim'

Plug 'vim-scripts/functionlist.vim'

Plug 'github/copilot.vim'

call plug#end()
