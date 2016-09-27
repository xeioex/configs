#! /bin/sh

pidof conky > /dev/null && echo restarting && killall conky

exec conky -c ~/.conkyrc
