#!/bin/bash
DATE=`date +%Y-%m-%d_%H-%M-%S`
FNAME="$HOME/Dropbox/Public/screenshots/$DATE.png"

shutter -e -C -s -o $FNAME

dropbox puburl $FNAME | xclip -selection clipboard
