#!/bin/bash

xsetroot -bg black
xsetroot -cursor_name left_ptr
sudo mount /dev/sdb1 ~/Games;
xinput --set-prop "$(xinput | grep Logitech | grep -E 'G402\s*id' | sed 's/^.*id=//' | sed 's/\s.*$//')" 'libinput Accel Profile Enabled' 0, 1
nohup lutris &> /dev/null & 
xrandr --output DisplayPort-1 --primary --right-of DisplayPort-2
setxkbmap -layout us,ir -option grp:alt_shift_toggle
killall mpd
