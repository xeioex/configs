#PATHs
PATH=/var/lib/gems/1.9.1/bin/:/home/xeioex/.gem/ruby/1.9.1/bin/:$PATH
PATH=/opt/llvm/llvm-3.3/bin/:$PATH
PATH=$PATH:$HOME/.rvm/bin

# Sources
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

if [ $(whoami) == "xeioex" ]; then
export WORKSPACE='~/workspace/undev/playout'
fi

if [ $(whoami) == "build" ]; then
export WORKSPACE='~/playout'
fi

export ESSENTIALCONFIGS='~/.bashrc ~/.inputrc ~/.gdbinit ~/.gdb_history ~/.bash_profile ~/.vimrc'

# aliases
if [[ $(whoami) -eq "xeioex" || $EXPALIAS ]]; then
shopt -s expand_aliases  #expand aliases in non-interactive shell
fi

alias ainstall='sudo apt-get install'
alias asearch='sudo apt-cache search'
alias ss='source ~/.bashrc'

# remote server helpers
alias reload-ssh-agent='ssh-agent /bin/bash; ssh-add'
alias ssh-copy-id='ssh-copy-id -i ~/.ssh/id_rsa.pub'
alias upload-essential-configs="scp  $ESSENTIALCONFIGS"
alias upload-all-configs="scp -r $ESSENTIALCONFIGS ~/.vim/"
alias install-essential='ainstall -y sshfs gdb'
alias mount-workspace='sshfs xeioex@192.168.215.32:/home/xeioex/workspace/ /root/workspace/'

function __prepare-server() {
        ssh-copy-id $1
        upload-essential-configs $1:~/
        ssh $1 "export EXPALIAS=1; source ~/.bashrc && install-essential"
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

alias mfind='find ./ -regextype posix-egrep'
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
function __enable-cores() {
        sudo sh -c "echo '/tmp/core.%t.%h.%e.%p' > /proc/sys/kernel/core_pattern; ulimit -c unlimited"
}
function __prepare-playout-env() {
        export LD_LIBRARY_PATH=./build/MLFoundation/:./build/MLStreams/:./build/Playout
        __enable-cores
}
alias prepare-playout-env='__prepare-playout-env'
alias prepare-workspace="cd $WORKSPACE; __prepare-playout-env"


alias playout-version='dpkg -l| grep playout'
alias playout-upgrade='apt-get update && apt-get install playout playout-dbg'
alias playout-gdb='gdb /usr/lib/debug/usr/bin/playout-launch'
alias playout-gdb-run='gdb --args /usr/bin/playout-launch'

# bash options 
export HISTTIMEFORMAT='%F %T '

# HOST only
if [[ $(whoami) -eq "xeioex" ]]; then
export BUILDENV='/home/xeioex/workspace/undev/build-env'
alias enter-build-env="cd $BUILDENV; cp $ESSENTIALCONFIGS ./home/build/;  sudo cp /etc/hosts $BUILDENV/etc/; sudo cp /proc/mounts $BUILDENV/etc/mtab; sudo chroot $BUILDENV"
fi

if [[ $(whoami) -eq "build" ]]; then
alias prepare-build-env="sudo -u build bash"
fi

if [[ $(whoami) -eq "xeioex" || $(whoami) -eq "build" ]]; then
export PS1='\[\e[33;1m\] [\@] \[\e[31;1m\]\#\[\e[33;1m\] \[\e[34;1m\]\u@\h\[\e[33;1m\] \w\n\[\e[0m\]\$ '
echo "WORKSPACE $WORKSPACE"
fi

export HISTSIZE=100000
#export HISTCONTROL=erasedups
# [ \t]*  - do not put to history cmd prefixed with space or tabs
export HISTIGNORE="&:ls:cd:[bf]g:exit:pwd:[ \t]*:ss"

export EDITOR=vim

