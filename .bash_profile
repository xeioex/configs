#!/usr/bin/env bash

# Interactive
# It's best if there's no output to stdout from login rc files such as ~/.bash_profile
# or ~/.profile since it can interfere with the proper operation of rsync for example.
BASHRC=~/.bashrc
if [[ $TMUX ]]; then
    if [ -f $BASHRC ]; then
        source $BASHRC
    fi
fi

export SSH_AUTH_SOCK="$GNOME_KEYRING_CONTROL/ssh"

