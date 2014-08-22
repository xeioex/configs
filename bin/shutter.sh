#!/bin/bash
DATE=`date +%Y-%m-%d_%H-%M-%S`

shutter -e -C -s -o "/var/www/screenshots/$DATE.png"

echo "http://192.168.215.220/screenshots/$DATE.png" | xclip -selection clipboard
