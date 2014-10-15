let paths = expand("$VIMINCPATHS")
if paths != ''
    execute ':set path+=' . paths
endif
