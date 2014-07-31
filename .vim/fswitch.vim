" smart source/header switch (fswitch plugin)
 augroup mycodefiles
   au!
   au BufEnter *.h let b:fswitchdst  = 'm,c,cc,cpp'
   au BufEnter *.h let b:fswitchlocs = 'reg:|Headers/Playout|Sources|,reg:|Headers/MLStreams|Sources|,reg:|Headers/MLFoundation|Sources|'
   au BufEnter *.m let b:fswitchdst  = 'h'
   au BufEnter *.m let b:fswitchlocs = 'reg:|Sources|Headers/Playout|,reg:|Sources|Headers/MLStreams|,reg:|Sources|Headers/MLFoundation|'
 augroup END

nmap <silent> <Leader>of :FSHere<cr>
