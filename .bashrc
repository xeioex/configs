# ENV VARS
#PATHs
PATH=/var/lib/gems/1.9.1/bin/:/home/xeioex/.gem/ruby/1.9.1/bin/:$PATH
PATH=/opt/llvm/llvm-3.3/bin:$PATH
PATH=$PATH:$HOME/.rvm/bin

# Global
export ESSENTIALCONFIGS="~/.bashrc ~/.inputrc ~/.gdbinit ~/.gdb_history ~/.bash_profile"
export ESSENTIALPACKETS="sshfs gdb linux-tools-2.6.32"
export WORKSPACE='~/workspace/undev/playout'
export EDITOR=vim

# Shell
export HISTTIMEFORMAT='%F %T '
export HISTSIZE=100000
export HISTIGNORE="&:ls:cd:[bf]g:exit:pwd:[ \t]*:ss"

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

# Nvm
if [ -f ~/.nvm/nvm.sh ]; then
    . ~/.nvm/nvm.sh
fi

if [ ! -d ~/workspace/ ]; then
    mkdir -p ~/workspace
fi

# aliases
if [[ $TMUX || $EXPALIAS ]]; then
    shopt -s expand_aliases  #expand aliases in non-interactive shell
fi

alias ss='source ~/.bashrc'

# Generic
alias ainstall='sudo apt-get install'
alias asearch='sudo apt-cache search'
alias install-essential="ainstall -y $ESSENTIALPACKETS"

alias ls='ls --color=auto'
alias mfind='find ./ -regextype posix-egrep'
alias grep="egrep --color=auto"

alias config-gcc='sudo update-alternatives --config gcc'
alias vbox-open='rdesktop 127.0.0.1'

# remote server helpers
alias freboot="echo 'b' > /proc/sysrq-trigger"
alias reload-ssh-agent='ssh-agent /bin/bash; ssh-add'
alias ssh-copy-id='ssh-copy-id -i ~/.ssh/id_rsa.pub'

if [[ $(hostname) == "xeioex-host" ]]; then
    alias upload-essential-configs="scp $ESSENTIALCONFIGS"
    alias upload-all-configs="scp -r $ESSENTIALCONFIGS ~/.vim/"
fi

if [[ $(hostname) != "xeioex-host" ]]; then
    alias mount-workspace='sshfs xeioex@192.168.215.32:/home/xeioex/workspace/ /root/workspace/'
fi

function __host-prepare() {
    ssh-copy-id $1
    upload-essential-configs $1:~/
    ssh  $1 "bash -ic install-essential"
}

function __host-enter() {
    __host-prepare $1
    ssh $1
}

alias host-prepare='__host-prepare'
alias host-enter="__host-enter"

# TMUX
# reload environment
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

alias tmux-enter-dev="~/.tmux/dev"
alias tmux-enter-aux="~/.tmux/aux"
alias tmux-kill-dev="tmux kill-session -t dev"
alias tmux-kill-aux="tmux kill-session -t aux"

# custom
function __enable-cores() {
    sudo sysctl -w kernel.core_pattern=/tmp/core.%t.%h.%e.%p
    ulimit -c unlimited
}
function __prepare-playout-env() {
    export LD_LIBRARY_PATH=./build/MLFoundation/:./build/MLStreams/:./build/Playout
    __enable-cores
}

alias prepare-playout-env='__prepare-playout-env'
alias prepare-workspace="cd $WORKSPACE; __prepare-playout-env"
alias vim-enter-dev="vim -S"

alias playout-nix-version="ls /nix/store/ | grep playout | grep -o 'playout.*' | sort"
alias playout-version='dpkg -l| grep playout'
alias playout-upgrade='apt-get update && apt-get install playout playout-dbg'
alias playout-gdb='gdb /usr/lib/debug/usr/bin/playout-launch'
alias playout-gdb-run='gdb --args /usr/bin/playout-launch'

# HOST only
if [[ $(hostname) == "xeioex-host" ]]; then
    if [[ $(whoami) == "xeioex" ]]; then
        export BUILDENVPATH='~/workspace/undev/build-env/'
        function __build-env-enter() {
        xauth extract - $DISPLAY | xauth -f $1/home/build/.Xauthority merge -
        cp /etc/hosts $1/etc/
        cp /proc/mounts $1/etc/mtab
        sudo chroot $1
        }
        alias build-env-enter="__build-env-enter $BUILDENVPATH"

        if [[ -z $TMUX ]]; then
            echo "tmux-enter-dev - to enter development session"
            echo "tmux-enter-aux - to enter aux session"
            echo "WORKSPACE $WORKSPACE"
        fi
    fi

    if [[ $(whoami) == "build" || $(whoami) == "root" ]]; then
        if [[ $(whoami) == "root" ]]; then
            alias prepare-build-env="sudo mount -a 2>/dev/null; sudo -u build BUILDENV=1 bash"
        fi
        unset XAUTHORITY
    fi

    export PS1='\[\e[33;1m\] [\@] \[\e[31;1m\]\#\[\e[33;1m\] \[\e[34;1m\]\u@\h\[\e[33;1m\] \w\n\[\e[0m\]\$ '

    if [[ "$BUILDENV" == "1" ]]; then
        export PS1="(build-env) $PS1"
    fi
fi
