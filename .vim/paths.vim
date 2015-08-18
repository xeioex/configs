let paths = expand("$VIMINCPATHS") " may be uncable to expand if variable is too long (~ >= 2kb)
if paths != '$VIMINCPATHS'
    execute ':set path+=' . paths
endif
