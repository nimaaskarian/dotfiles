#!/bin/bash

setxkbmap -layout us,ir -option 'grp:alt_shift_toggle'
# xmodmap -e "clear lock" #disable caps lock switch
# xmodmap -e "keysym Caps_Lock = Escape" #set caps_lock as escape
setxkbmap -option "caps:swapescape"
