#! /bin/sh

pidof dzen2 > /dev/null && echo restarting && killall dzen2

exec dzen2 -x '1440' -y '0' -h '24' -w '1000' -ta 'l' -fg '#FFFFFF' -bg '#1B1D1E'
