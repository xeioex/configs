" Syntastic setup
let g:syntastic_mode_map = { 'mode': 'active', 'active_filetypes': ['objc', 'c', 'cpp']}

let g:syntastic_objc_check_header = 1
let g:syntastic_objc_include_dirs = [ 'Headers', 'MLStreams/Headers/', 'MLStreams/MLFoundation/Headers/']
