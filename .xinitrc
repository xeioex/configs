eval $(gnome-keyring-daemon --start)
export GNOME_KEYRING_SOCKET
export GNOME_KEYRING_PID

setxkbmap us,ru -option grp:alt_shift_toggle
pacmd set-default-sink alsa_output.usb-ESI_Audiotechnik_GmbH_Dr._DAC_nano-01-nano.analog-stereo
xrandr --output VGA1 --primary --left-of HDMI1 --output HDMI1 --auto
