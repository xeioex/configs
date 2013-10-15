#!/usr/bin/env bash
export VOLYNTSEVHOST="xeioex-host"
export VOLYNTSEVIP="192.168.215.32"

if [[ $(hostname) == $VOLYNTSEVHOST || $(echo $SSH_CONNECTION | egrep -o '^[0-9.]+') == $VOLYNTSEVIP ]]; then
    # Global
    export EDITOR=vim
    export USER=xeioex
    export HOST=$VOLYNTSEVHOST
    export HOSTIP=$(ip addr|grep inet.*eth0|egrep -m 1 -o 'inet [0-9]+.[0-9]+.[0-9]+.[0-9]+' | sed 's/inet //')

    if [[ $HOSTIP == $VOLYNTSEVIP ]]; then
        export HOSTIP='home'
    fi

    export WORKSPACE="$HOME/workspace"
    export PWORKSPACE="$WORKSPACE/undev/playout"
    export DWORKSPACE="$WORKSPACE/undev/deligra"
    export DEVNIXPATH="$WORKSPACE/undev/nix-pkgs"

    export ESSENTIALCONFIGS="~/.bashrc ~/.inputrc ~/.gdbinit ~/.gdb_history ~/.bash_profile"
    export ESSENTIALPACKETS="sshfs aufs-tools gdb linux-tools-2.6.32 rlwrap"
    export ESSENTIALDBGPACKETS="libc6-dbg libgnustep-base1.19-dbg libffi5-dbg"

    # Shell
    export HISTTIMEFORMAT='%F %T '
    export HISTSIZE=100000
    export HISTIGNORE="&:ls:cd:[bf]g:exit:pwd:[ \t]*:ss"

    export PS1="\[\e[33;1m\] [\@] \[\e[31;1m\]\#\[\e[33;1m\] \[\e[34;1m\] $HOSTIP \u@\h\[\e[33;1m\] \w\n\[\e[0m\]\$ "

    # AUX
    export SSHRTUNNELPORT='11111'

    # NIX
    export NIX_REMOTE=daemon
fi

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Nix
if [ -f /etc/profile.d/nix.sh ]; then
    . /etc/profile.d/nix.sh
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
    mkdir -p ~/workspace 2>/dev/null
fi

if [ ! -d ~/.gdb/ ]; then
    mkdir -p ~/.gdb 2>/dev/null
fi

# aliases
if [[ $TMUX || $EXPALIAS ]]; then
    shopt -s expand_aliases  #expand aliases in non-interactive shell
fi

alias ss='source ~/.bashrc'

# Generic
alias ainstall='sudo apt-get install'
alias ainstall-dont-ask='sudo apt-get install -y --force-yes'
alias asearch='sudo apt-cache search'
alias install-essential="ainstall -y $ESSENTIALPACKETS"
alias install-essential-dbg="ainstall -y $ESSENTIALDBGPACKETS"

alias clean-build="rm -fr ./build/ && rm -fr .scon*"

alias ls='ls --color=auto'
alias mfind='find ./ -regextype posix-egrep'
alias grep='egrep --color=auto'
alias ldd='bash ldd'
alias unix-now='date +"%s"'
alias unix-now-diff="perl -e 'print time - shift();print \"\n\";'"

alias cursor-invisible='tput cinvis'
alias cursor-visible='tput cnorm'

alias config-gcc='sudo update-alternatives --config gcc'

alias kill-service='pkill -9 -f'
alias kill-all-playout='pkill -9 -f playout'
alias kill-current-tty-playout="pkill -KILL -t $(tty | sed 's/\/dev\///') -f playout"

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

    export "$1_run_path"="/etc/sv/$2/"
    alias $1-run="cat \$$1_run_path/run"
    alias $1-run-open="vim \$$1_run_path/run"
    alias $1-restart="sv restart \$$1_run_path"
    alias $1-start="sv start \$$1_run_path"
    alias $1-stop="sv stop \$$1_run_path"
}

if [[ $(hostname) == $HOST ]]; then
    # ENV VARS
    #PATHs
    #PATH=/var/lib/gems/1.9.1/bin/:/home/xeioex/.gem/ruby/1.9.1/bin/:$PATH
    #PATH=/opt/llvm/llvm-3.3/bin:$PATH
    #PATH=$PATH:$HOME/.rvm/bin

    # disabling XOFF
    stty ixany
    stty ixoff -ixon

    alias upload-essential-configs="scp $ESSENTIALCONFIGS"
    alias upload-all-configs="scp -r $ESSENTIALCONFIGS ~/.vim/"

    alias vbox-open='rdesktop 127.0.0.1'
fi

if [[ $(hostname) != $HOST ]]; then
    #export DISPLAY=":0.0"
    function __mount-workspace() {
        if [ ! -f $PWORKSPACE ]; then
            which sshfs
            if [[ $? -ne 0 ]]; then
                echo "sshfs not available, installing"
                ainstall-dont-ask sshfs
            fi
            sshfs -p $SSHRTUNNELPORT $USER@localhost:/home/$USER/workspace/ /root/workspace/
            if [[ $? -ne 0 ]]; then
                echo "Can't mount $PWORKSPACE. Try umount -l /root/workspace/ and do sshfs again"
            fi
        fi
    }

    function __mount-rw-nix() {
        RW_NIX=/tmp/volyntsev-nix
        mkdir -p $RW_NIX

        which mount.aufs
        if [[ $? -ne 0 ]]; then
            ainstall aufs-tools
        fi

        RES=$(mount | grep nix  | grep aufs | wc -l)

        if [[ $RES -ne "1" ]]; then
            mount -t aufs -o br=$RW_NIX=rw:/nix=ro -o udba=reval none /nix
        fi
    }

    alias mount-workspace="__mount-workspace"
    alias mount-rw-nix="__mount-rw-nix"
    alias prepare-workspace="mount-workspace; mount-rw-nix; cd $PWORKSPACE; __prepare-playout-env"

    alias install-root-essential-configs="sudo cp $ESSENTIALCONFIGS /root/"
    alias root-shell-enter="install-root-essential-configs; sudo -i"

    alias restart-all="sv restart /etc/sv/*"
    alias stop-all="sv restart /etc/sv/*"
    declare-service-aliases "sdi" "sdi-grabber" "sdi_grabber/sdi-input.podsl"
    declare-service-aliases "m2l" "m2l-transcoder" "m2l-transcoder/m2l-transcoder.podsl"
    declare-service-aliases "rtsp" "rtsp-grabber" "rtsp_grabber/rtsp-grabber.podsl"
    declare-service-aliases "ts" "ts-streamer-0" "ts_streamer/ts-0.podsl"
    declare-service-aliases "blue7" "playout-blue7-0" "playout-blue7/playout-blue7-0.podsl"
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

function __prepare-nix-env() {
    which nix-build
    if [[ $? -ne 0 ]]; then
        echo "nix-env not available, installing"
        wget http://hydra.nixos.org/build/3668881/download/1/nix_1.3-1_amd64.deb
        sudo dpkg -i ./nix_1.3-1_amd64.deb
        sudo apt-get -y -f install
        sudo nix-channel --add http://nix.undev.cc/channel
        sudo nix-channel --update
    fi

    export NIX_ENV=$1
    export NIX_REMOTE=daemon
    sudo pkill nix-daemon
    sudo nix-channel --update
    sudo nohup nix-daemon &
    nix-build --run-env -A $1 $2
}

function __prepare-playout-env() {
    export LD_LIBRARY_PATH=./build/MLFoundation/:./build/MLStreams/:./build/Playout
    __enable-cores
    __prepare-nix-env playout-develop $DEVNIXPATH
}

function __prepare-deligra-env() {
    export LD_LIBRARY_PATH=./lib
    __enable-cores
    __prepare-nix-env deligra-develop $DEVNIXPATH
}

function __netem-activate() {
    sudo modprobe ifb
    sudo ip link set dev ifb0 up
    sudo tc qdisc add dev eth0 ingress
    sudo tc filter add dev eth0 parent ffff: protocol ip u32 match u32 0 0 flowid 1:1 action mirred egress redirect dev ifb0
}

function __netem-clear-qdisc() {
    sudo tc qdisc delete dev ifb0 root
    sudo tc qdisc delete dev eth0 root
}

alias netem-activate="__netem-activate"
alias netem-clear="__netem-clear-qdisc"

alias vim-enter-dev='vim -S'

alias prepare-playout-env="__prepare-playout-env playout-develop $DEVNIXPATH"
alias prepare-nix-env='__prepare-nix-env'
alias run-playout-with-clean-env='kill-current-tty-playout; sleep 1 &&'

alias playout-nix-version="ls /nix/store/ | grep playout | grep -o 'playout.*' | sort"
alias playout-version='dpkg -l| grep playout'
alias playout-upgrade='apt-get update && apt-get install playout playout-dbg'
alias playout-gdb='gdb /usr/lib/debug/usr/bin/playout-launch'
alias playout-gdb-run='gdb --args /usr/bin/playout-launch'

alias prepare-deligra-env="cd $DWORKSPACE;__prepare-deligra-env"
alias run-sdigra-in-nix-env="LD_PRELOAD=/usr/lib/libDeckLinkAPI.so:/usr/lib/libz.so.1:/usr/lib/libxml2.so.2 "

alias gdb-run='gdb --args'

alias strip-escape-colors='sed -r "s/\x1B\[([0-9]{1,3}((;[0-9]{1,3})*)?)?[m|K]//g'

# HOST only
if [[ $(hostname) == $HOST ]]; then
    alias prepare-workspace="cd $PWORKSPACE; __prepare-playout-env"
    if [[ $(whoami) == $USER ]]; then
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
            alias prepare-build-env="sudo mount -a; sudo -u build BUILDENV=1 bash"
        fi
        unset XAUTHORITY
    fi

    if [[ "$BUILDENV" == "1" ]]; then
        export PS1="(build-env) $PS1"
    fi
fi

if [ -n "$NIX_LDFLAGS" ] ; then
    export PS1="(nix:$NIX_ENV) $PS1"
fi
