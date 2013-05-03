#PATHs
PATH=/home/xeioex/java/jdk1.6.0_25/bin:$PATH

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

# Compiling
alias findso='find ./ -type f -name "*.so"'
alias finda='find ./ -type f -name "*.a"'

alias config-gcc='sudo update-alternatives --config gcc'

#exports 
export HISTTIMEFORMAT='%F %T '
#export PROMPT_COMMAND='history -a;history -n'
#export PS1='[`date +'%m-%d-%H:%M'`] \u@\h \w\n \$'
export PS1='\[\e[33;1m\] [\@] \[\e[31;1m\]\#\[\e[33;1m\] \[\e[34;1m\]\u@\h\[\e[33;1m\] \w\n\[\e[0m\]\$ '
export HISTSIZE=10000
export HISTCONTROL=ignoredups
export HISTIGNORE="&:ls:[bf]g:exit:[ ]*:ssh:history"

alias prep='cd ~/workspace/undev/playout/;export LD_LIBRARY_PATH=./build/MLFoundation/:./build/MLStreams/:./build/Playout; echo "/tmp/core.%t.%h.%e.%p" > /proc/sys/kernel/core_pattern'
