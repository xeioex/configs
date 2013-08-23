# ENV VARS
#PATHs
PATH=/var/lib/gems/1.9.1/bin/:/home/xeioex/.gem/ruby/1.9.1/bin/:$PATH
PATH=/opt/llvm/llvm-3.3/bin:$PATH
PATH=$PATH:$HOME/.rvm/bin

# Global
export ESSENTIALCONFIGS="~/.bashrc ~/.inputrc ~/.gdbinit ~/.gdb_history ~/.bash_profile"
export ESSENTIALPACKETS="sshfs gdb linux-tools-2.6.32 rlwrap"
export ESSENTIALDBGPACKETS="libc6-dbg libgnustep-base1.19-dbg libffi5-dbg"
export WORKSPACE="$HOME/workspace/undev/playout"
export EDITOR=vim

# Shell
export HISTTIMEFORMAT='%F %T '
export HISTSIZE=100000
export HISTIGNORE="&:ls:cd:[bf]g:exit:pwd:[ \t]*:ss"

export BREAK_CHARS="\"#'(),;\`\\|!?[]{}"
alias sbcl-console="rlwrap -b \$BREAK_CHARS sbcl"

# AUX
export SSHRTUNNELPORT='11111'

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
alias install-essential-dbg="ainstall -y $ESSENTIALDBGPACKETS"

alias ls='ls --color=auto'
alias mfind='find ./ -regextype posix-egrep'
alias grep='egrep --color=auto'

alias config-gcc='sudo update-alternatives --config gcc'

alias kill-service='pkill -9 -f'
alias kill-playout='pkill -9 -f playout'

# remote server helpers
alias freboot="echo 'b' > /proc/sysrq-trigger"
alias reload-ssh-agent='eval `ssh-agent -s`; ssh-add'
alias ssh-copy-id='ssh-copy-id -i ~/.ssh/id_rsa.pub'

# prefix name
function declare-service-aliases()
{
    export "$1_log_path"="/storage/log/$2/current"
    alias $1-log="tailf \$$1_log_path"
    alias $1-log-list="'less -R \$$1_log_path"
    alias $1-log-open="vim \$$1_log_path"

    export "$1_cfg_path"="/etc/platform/$3"
    alias $1-cfg="vim \$$1_cfg_path"

    export "$1_run_path"="/etc/sv/$2/run"
    alias $1-run="cat \$$1_run_path"
    alias $1-run-open="vim \$$1_run_path"
    alias $1-restart="sv restart \$$1_run_path"
    alias $1-start="sv start \$$1_run_path"
    alias $1-stop="sv stop \$$1_run_path"
}

if [[ $(hostname) == "xeioex-host" ]]; then
    # disabling XOFF
    stty ixany
    stty ixoff -ixon

    alias upload-essential-configs="scp $ESSENTIALCONFIGS"
    alias upload-all-configs="scp -r $ESSENTIALCONFIGS ~/.vim/"

    alias vbox-open='rdesktop 127.0.0.1'
fi

if [[ $(hostname) != "xeioex-host" ]]; then

    function __mount-workspace() {
        if [ ! -f $WORKSPACE ]; then
            sshfs -p $SSHRTUNNELPORT xeioex@localhost:/home/xeioex/workspace/ /root/workspace/
        fi
    }

    alias mount-workspace="__mount-workspace"
    alias prepare-workspace="mount-workspace; cd $WORKSPACE; __prepare-playout-env"

    alias install-root-essential-configs="sudo cp $ESSENTIALCONFIGS /root/"
    alias root-shell-enter="install-root-essential-configs; sudo -i"

    alias restart-all="sv restart /etc/sv/*"
    alias stop-all="sv restart /etc/sv/*"
    declare-service-aliases "sdi" "sdi-grabber" "sdi_grabber/sdi-input.podsl"
    declare-service-aliases "m2l" "m2l-transcoder" "m2l-transcoder/m2l-transcoder.podsl"
    declare-service-aliases "rtsp" "rtsp-grabber" "rtsp_grabber/rtsp-grabber.podsl"
    declare-service-aliases "ts" "ts-streamer-0" "ts_streamer/ts-0.podsl"
    declare-service-aliases "rtmp" "rtmp-streamer-0" "rtmp_streamer/rtmp-0.podsl"
    declare-service-aliases "sdigra0" "sdigra-0" "sdigra0"
    declare-service-aliases "sdigra1" "sdigra-1" "sdigra1"
    declare-service-aliases "sdigra2" "sdigra-2" "sdigra2"
    declare-service-aliases "sdigra3" "sdigra-3" "sdigra3"
fi

function __host-prepare() {
    ssh-copy-id $2
    upload-essential-configs $2:~/
    scp  ~/.vimrc_minimal $2:~/.vimrc
    if [[ $1 ==  "1" ]]; then
        echo "host $2 enter, preparing debug env"
        ssh  $2 "bash -ic install-essential"
    fi
}

function __host-enter() {
    __host-prepare $1 $2
    ssh -X -R $SSHRTUNNELPORT:localhost:22 $2
}

alias host-enter='__host-enter 0'
alias host-enter-dbg='__host-enter 1'

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

alias tmux-enter-dev='~/.tmux/dev'
alias tmux-enter-aux='~/.tmux/aux'
alias tmux-kill-dev='tmux kill-session -t dev'
alias tmux-kill-aux='tmux kill-session -t aux'

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
alias vim-enter-dev='vim -S'

alias playout-nix-version="ls /nix/store/ | grep playout | grep -o 'playout.*' | sort"
alias playout-version='dpkg -l| grep playout'
alias playout-upgrade='apt-get update && apt-get install playout playout-dbg'
alias playout-gdb='gdb /usr/lib/debug/usr/bin/playout-launch'
alias playout-gdb-run='gdb --args /usr/bin/playout-launch'

alias strip-escape-colors='sed -r "s/\x1B\[([0-9]{1,3}((;[0-9]{1,3})*)?)?[m|K]//g'

# HOST only
if [[ $(hostname) == "xeioex-host" ]]; then
    alias prepare-workspace="cd $WORKSPACE; __prepare-playout-env"
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
