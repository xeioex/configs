#PATHs
PATH=/var/lib/gems/1.9.1/bin/:/home/xeioex/.gem/ruby/1.9.1/bin/:$PATH
PATH=/opt/llvm/llvm-3.3/bin/:$PATH
PATH=$PATH:$HOME/.rvm/bin

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Sources

# Cdargs
if [ -f /usr/share/doc/cdargs/examples/cdargs-bash.sh ]; then
    . /usr/share/doc/cdargs/examples/cdargs-bash.sh
fi

# Completion
if [ -f /etc/bash_completion ]; then
. /etc/bash_completion
fi

# Nvm
if [ -f ~/.nvm/nvm.sh ]; then
. ~/.nvm/nvm.sh
fi

if [ ! -d ~/workspace/ ]; then
mkdir -p ~/workspace
fi

# aliases
shopt -s expand_aliases # expand aliases in non-interactive shell
alias ainstall='sudo apt-get install'
alias ss='source ~/.bashrc'

# remote server helpers
alias ssh-copy-id='ssh-copy-id -i ~/.ssh/id_rsa.pub'
alias upload-essential-configs='scp  ~/.bashrc'
alias upload-all-configs='scp -r ~/.bashrc ~/.vimrc ~/.vim/'
alias install-essential='ainstall -y sshfs gdb'
alias mount-workspace='sshfs xeioex@192.168.215.32:/home/xeioex/workspace/ /root/workspace/'

function __prepare-server() {
        ssh-copy-id $1
        upload-essential-configs $1:~/
        ssh $1 "source ~/.bashrc && install-essential"
}

# tmux reload environment
if [ -n "$(which tmux 2>/dev/null)" ]; then
    function tmux() {
        local tmux=$(type -fp tmux)
        case "$1" in
            update-environment|update-env|env-update)
                local v
                while read v; do
                    echo "processing $v"
                    if [[ $v == -* ]]; then
                        v=$(echo "$v" | sed -e 's/=.*//')
                        unset ${v/#-/}
                    else
                        # Add quotes around the argument
                        v=${v/=/=\"}
                        v=${v/%/\"}
                        eval export $v
                    fi
                done < <(tmux show-environment)
                ;;
            *)
                $tmux "$@"
                ;;
        esac
    }
fi

alias prepare-server='__prepare-server'

alias ..="cd .."
alias ....="cd ../.."
alias ls='ls --color=auto'

alias find='find ./ -regextype posix-egrep'
alias grep="egrep --color=auto"


alias config-gcc='sudo update-alternatives --config gcc'

# Typo aliases
alias ,,="cd .."
alias ..l="cd .. && ls"
alias cd..="cd .."
alias gits="git s"
alias mdkir="mkdir"
alias gut="git"
alias sudp="sudo"

# custom
alias prepare-workspace='cd ~/workspace/undev/playout/;export LD_LIBRARY_PATH=./build/MLFoundation/:./build/MLStreams/:./build/Playout; echo "/tmp/core.%t.%h.%e.%p" > /proc/sys/kernel/core_pattern; ulimit -c unlimited'

alias playout-version='dpkg -l| grep playout'
alias playout-upgrade='apt-get update && apt-get install playout playout-dbg'
alias playout-gdb='gdb /usr/lib/debug/usr/bin/playout-launch'
alias playout-gdb-run='gdb --args /usr/bin/playout-launch'

# bash options 
export HISTTIMEFORMAT='%F %T '
export PS1='\[\e[33;1m\] [\@] \[\e[31;1m\]\#\[\e[33;1m\] \[\e[34;1m\]\u@\h\[\e[33;1m\] \w\n\[\e[0m\]\$ '
export HISTSIZE=100000
export HISTCONTROL=erasedups
# [ \t]*  - do not put to history cmd prefixed with space or tabs
export HISTIGNORE="&:ls:cd:[bf]g:exit:pwd:[ \t]*:ss"
