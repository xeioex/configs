eval $(gnome-keyring-daemon --start)
export GNOME_KEYRING_SOCKET
export GNOME_KEYRING_PID

setxkbmap us,ru -option grp:alt_shift_toggle
xrandr --output VGA-1 --primary --left-of HDMI-1 --output HDMI-1 --auto
