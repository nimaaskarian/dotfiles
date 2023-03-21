#!/bin/bash

sudo mount /dev/sdb1 ~/Games;
xinput --set-prop 10 'libinput Accel Profile Enabled' 0, 1;
nohup lutris &> /dev/null & 
xrandr --output DisplayPort-2 --primary --right-of DisplayPort-1
xsetroot -bg black
xsetroot -cursor_name left_ptr
killall mpd
