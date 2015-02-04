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

" used for fuzzyFinder
Plugin 'L9'
" find files, tags, buffers, etc by fuzzy patterns
" example 1: Fufile **/RTSP will find all files with filenames whicn contain "RTSP" substring
" in all vim path diretories
Plugin 'FuzzyFinder'
" file manager
Plugin 'scrooloose/nerdtree'
" visualize changes as tree
Plugin 'sjl/gundo.vim'
"Plugin 'vim-scripts/GdbFromVim'
Plugin 'vim-scripts/JSON.vim'
" Hooks the make quickfix command and converts all compiler errors into signs
" that are placed next to the line with the error
Plugin 'vim-scripts/errormarker.vim'
" Provides highlighting for  #ifdef  #ifndef  #else  #endif  blocks, with the
" ability to mark a symbol as defined or undefined
Plugin 'vim-scripts/ifdef-highlighting'
" switch between source and header files
Plugin 'derekwyatt/vim-fswitch'
" integrates the LanguageTool grammar checker into Vim
Plugin 'vim-scripts/LanguageTool'
" perform Google searches from the command line
" :Goog <query>
Plugin 'danchoi/goog'
" plugins runtime reload
Plugin 'xolox/vim-reload'
Plugin 'xolox/vim-misc'

Plugin 'xolox/vim-session'
Plugin 'xolox/vim-shell'

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

":h yankring.txt
":h yankring-tutorial
Plugin 'vim-scripts/YankRing.vim'

" implements some of TextMate's snippets features in Vim. A snippet is a piece
" of often-typed text that you can insert into your document using a trigger
" word followed by a <tab>. 
Plugin 'msanders/snipmate.vim'
" help edit XML documents. It includes tag completion and tag jumping
Plugin 'sukima/xmledit'
" camelCaseMotions
Plugin 'bkad/CamelCaseMotion'
" allows you to run interactive programs, such as bash on linux or
" powershell.exe on Windows, inside a Vim buffer
Plugin 'vim-scripts/Conque-Shell'
" using ack instead of grep from vim
Plugin 'mileszs/ack.vim'
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
" Files with ANSI escape sequences look good when dumped onto a terminal that
" accepts them, but have been a distracting clutter when edited via vim
Plugin 'vim-scripts/AnsiEsc.vim'
" using * for search for current visual selection
Plugin 'vim-scripts/visualstar.vim'
" populated arglist with quickfix list files
Plugin 'nelstrom/vim-qargs'
" Highlight matching parens in a rainbow of colors
Plugin 'kien/rainbow_parentheses.vim'

"  It handles syntax, indenting, compiling, and more. Also included is support
"  for CoffeeScript in Haml and HTML.
Plugin 'kchmck/vim-coffee-script'

Plugin 'jnwhiteh/vim-golang'

Plugin 'vim-scripts/slimv.vim'

Plugin 'vim-scripts/functionlist.vim'

" Conveniently shows loaded bundles and plugins
"Plugin 'mbadran/headlights'

" vim-codefmt
Plugin 'google/vim-maktaba'
Plugin 'google/vim-codefmtlib'
Plugin 'google/vim-codefmt'

" non github repos
Plugin 'git://git.wincent.com/command-t.git'

call vundle#end()             " required
filetype plugin indent on     " required!


source ~/.vim/bundle/slimv.vim/ftplugin/lisp/slimv-lisp.vim
