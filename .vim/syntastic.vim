" Syntastic setup
let g:syntastic_mode_map = { 'mode': 'active', 'active_filetypes': ['objc', 'c', 'cpp']}
let g:syntastic_disabled_filetypes=['html', 'js', 'json', 'lisp', 'python']

let g:syntastic_objc_check_header = 1
let g:syntastic_objc_include_dirs = [ 'Headers', 'MLStreams/Headers/', 'MLStreams/MLFoundation/Headers/']

let g:syntastic_cpp_compiler = 'clang++-3.9'
let g:syntastic_cpp_compiler_options = '-std=c++11'
