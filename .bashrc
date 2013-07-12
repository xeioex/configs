#PATHs
PATH=/var/lib/gems/1.9.1/bin/:/home/xeioex/.gem/ruby/1.9.1/bin/:$PATH
PATH=/opt/llvm/llvm-3.3/bin/:$PATH
PATH=$PATH:$HOME/.rvm/bin

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Cdargs
if [ -f /usr/share/doc/cdargs/examples/cdargs-bash.sh ]; then
    . /usr/share/doc/cdargs/examples/cdargs-bash.sh
fi

# Completion
if [ -f /etc/bash_completion ]; then
. /etc/bash_completion
fi

# aliases
alias ainstall='sudo apt-get install'
alias ss='source ~/.bashrc'

alias ls='ls --color=always'

alias find='find -regextype posix-egrep'

# custom
alias prep='cd ~/workspace/undev/playout/;export LD_LIBRARY_PATH=./build/MLFoundation/:./build/MLStreams/:./build/Playout; echo "/tmp/core.%t.%h.%e.%p" > /proc/sys/kernel/core_pattern'

alias config-gcc='sudo update-alternatives --config gcc'

# bash options 
export HISTTIMEFORMAT='%F %T '
export PS1='\[\e[33;1m\] [\@] \[\e[31;1m\]\#\[\e[33;1m\] \[\e[34;1m\]\u@\h\[\e[33;1m\] \w\n\[\e[0m\]\$ '
export HISTSIZE=100000
export HISTCONTROL=erasedups
# [ \t]*  - do not put to history cmd prefixed with space or tabs
export HISTIGNORE="&:ls:cd:[bf]g:exit:pwd:[ \t]*:ss"

# Run for each sub-shell 
prep


