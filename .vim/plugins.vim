"pathogen (runtime path manipulator)

filetype off

call pathogen#infect()
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

filetype plugin on
filetype plugin indent on

"vundle (plugin manager/updater)
filetype off  " required!

set rtp+=~/.vim/vundle.git/
call vundle#rc()
Bundle 'vundle'

" :scriptsname - shows all loaded plugins

"
" path to github or other repo for plugins
"

" used for fuzzyFinder
Bundle 'L9'
" find files, tags, buffers, etc by fuzzy patterns
" example 1: Fufile **/RTSP will find all files with filenames whicn contain "RTSP" substring
" in all vim path diretories
Bundle 'FuzzyFinder'
" file manager
Bundle 'scrooloose/nerdtree'
" visualize changes as tree
Bundle 'sjl/gundo.vim'
"Bundle 'vim-scripts/GdbFromVim'
Bundle 'vim-scripts/JSON.vim'
" Hooks the make quickfix command and converts all compiler errors into signs
" that are placed next to the line with the error
Bundle 'vim-scripts/errormarker.vim'
" Provides highlighting for  #ifdef  #ifndef  #else  #endif  blocks, with the
" ability to mark a symbol as defined or undefined
Bundle 'vim-scripts/ifdef-highlighting'
" switch between source and header files
Bundle 'derekwyatt/vim-fswitch'
" integrates the LanguageTool grammar checker into Vim
Bundle 'vim-scripts/LanguageTool'
" perform Google searches from the command line
" :Goog <query>
Bundle 'danchoi/goog'
" plugins runtime reload
Bundle 'xolox/vim-reload'
Bundle 'xolox/vim-misc'

" git wrapper
Bundle 'tpope/vim-fugitive'
" handling surrounds: example cs"' inside "phase inside quote" convert it to 'phrase inside quote'
Bundle 'tpope/vim-surround'
" Repeat.vim remaps . in a way that plugins can tap into it
Bundle 'tpope/vim-repeat'
" supercharged substitute command
" example 1:%S/{man,dog}/{dog,man}/g will replace man -> dog and dog -> man in
" one replace command
" :%S/facilit{y,ies}/building{,s}/g
Bundle 'tpope/vim-abolish'

":h yankring.txt
":h yankring-tutorial
Bundle 'vim-scripts/YankRing.vim'

" implements some of TextMate's snippets features in Vim. A snippet is a piece
" of often-typed text that you can insert into your document using a trigger
" word followed by a <tab>. 
Bundle 'msanders/snipmate.vim'
" help edit XML documents. It includes tag completion and tag jumping
Bundle 'sukima/xmledit'
" camelCaseMotions
Bundle 'bkad/CamelCaseMotion'
" allows you to run interactive programs, such as bash on linux or
" powershell.exe on Windows, inside a Vim buffer
Bundle 'vim-scripts/Conque-Shell'
" using ack instead of grep from vim
Bundle 'mileszs/ack.vim'
" create a temporary scratch buffer to store
" and edit text that will be discarded when you quit/exit vim
Bundle 'vim-scripts/scratch.vim'
" aligning text
" example 1: Tabularize /,
"     Some short phrase,some other phrase
"     A much longer phrase here,and another long phrase
"
"     Some short phrase         , some other phrase
"     A much longer phrase here , and another long phrase
Bundle 'godlygeek/tabular'
" Buffer explorer
Bundle 'corntrace/bufexplorer'
" Syntastic is a syntax checking plugin that runs files through external
" syntax checkers and displays any resulting errors to the user. This can be
" done on demand, or automatically as files are saved
Bundle 'scrooloose/syntastic'
" Files with ANSI escape sequences look good when dumped onto a terminal that
" accepts them, but have been a distracting clutter when edited via vim
Bundle 'vim-scripts/AnsiEsc.vim'
" using * for search for current visual selection
Bundle 'vim-scripts/visualstar.vim'
" populated arglist with quickfix list files
Bundle 'nelstrom/vim-qargs'
" Highlight matching parens in a rainbow of colors
Bundle 'vim-scripts/Rainbow-Parenthesis'

"  It handles syntax, indenting, compiling, and more. Also included is support
"  for CoffeeScript in Haml and HTML.
Bundle 'kchmck/vim-coffee-script'

Bundle 'jnwhiteh/vim-golang'

"Bundle 'vim-scripts/slimv.vim'

" Conveniently shows loaded bundles and plugins
"Bundle 'mbadran/headlights'

" non github repos
Bundle 'git://git.wincent.com/command-t.git'

filetype plugin indent on     " required!
