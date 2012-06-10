#PATHs
PATH=/home/xeioex/java/jdk1.6.0_25/bin:$PATH

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# aliases
alias ainstall='sudo apt-get install'
alias ss='source ~/.bashrc'

alias findso='find ./ -type f -name "*.so"'
alias finda='find ./ -type f -name "*.a"'

alias config-gcc='sudo update-alternatives --config gcc'

#exports 
export HISTTIMEFORMAT='%F %T '
export PROMPT_COMMAND='history -a;history -n'
export PS1='\[\e[33;1m\] [\@] \[\e[31;1m\]\#\[\e[33;1m\] \[\e[34;1m\]\u@\h\[\e[33;1m\] \w\n\[\e[0m\]\$ '
export HISTSIZE=10000
export HISTCONTROL=ignoredups
export HISTIGNORE="&:ls:[bf]g:exit:[ ]*:ssh:history"

#completion
if [ -f /etc/bash_completion ]; then
. /etc/bash_completion
fi
