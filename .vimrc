set nocompatible
source ~/.vim/global.vim
source ~/.vim/maps.vim
source ~/.vim/paths.vim

source ~/.vim/edit.vim
source ~/.vim/tags.vim
source ~/.vim/hls.vim
source ~/.vim/indent.vim
source ~/.vim/syntax.vim
source ~/.vim/navigation.vim
source ~/.vim/spell.vim
source ~/.vim/langs.vim

source ~/.vim/sessions.vim

" various routines
source ~/.vim/routines.vim

source ~/.vim/autocomplete.vim
source ~/.vim/git.vim

"plugins setups
source ~/.vim/plugins.vim

"project setups
let project = expand("$PROJECT")
let g:projectcfg = tolower('~/.vim/projects/'. project . '.vim')
if project != ''
    execute ":source ".g:projectcfg
endif

" INFO
":abbreviate   - list abbreviations
":args         - argument list
":augroup      - augroups
":autocmd      - list auto-commands
":buffers      - list buffers
":breaklist    - list current breakpoints
":cabbrev      - list command mode abbreviations
":changes      - changes
":cmap         - list command mode maps
":command      - list commands
":compiler     - list compiler scripts
":digraphs     - digraphs
":file         - print filename, cursor position and status (like Ctrl-G)
":filetype     - on/off settings for filetype detect/plugins/indent
":function     - list user-defined functions (names and argument lists but not the full code)
":function Foo - user-defined function Foo() (full code list)
":highlight    - highlight groups
":history c    - command history
":history =    - expression history
":history s    - search history
":history      - your commands
":iabbrev      - list insert mode abbreviations
":imap         - list insert mode maps
":intro        - the Vim splash screen, with summary version info
":jumps        - your movements
":language     - current language settings
":let          - all variables
":let FooBar   - variable FooBar
":let g:       - global variables
":let v:       - Vim variables
":list         - buffer lines (many similar commands)
":lmap         - language mappings (set by keymap or by lmap)
":ls           - buffers
":ls!          - buffers, including "unlisted" buffers
":map!         - Insert and Command-line mode maps (imap, cmap)
":map          - Normal and Visual mode maps (nmap, vmap, xmap, smap, omap)
":map<buffer>  - buffer local Normal and Visual mode maps
":map!<buffer> - buffer local Insert and Command-line mode maps
":marks        - marks
":menu         - menu items
":messages     - message history
":nmap         - Normal-mode mappings only
":omap         - Operator-pending mode mappings only
":print        - display buffer lines (useful after :g or with a range)
":reg          - registers
":scriptnames  - all scripts sourced so far
":set all      - all options, including defaults
":setglobal    - global option values
":setlocal     - local option values
":set          - options with non-default value
":set termcap  - list terminal codes and terminal keys
":smap         - Select-mode mappings only
":spellinfo    - spellfiles used
":syntax       - syntax items
":syn sync     - current syntax sync mode
":tabs         - tab pages
":tags         - tag stack contents
":undolist     - leaves of the undo tree
":verbose      - show info about where a map or autocmd or function is defined
":version      - list version and build options
":vmap         - Visual and Select mode mappings only
":winpos       - Vim window position (gui)
":xmap         - visual mode maps only
