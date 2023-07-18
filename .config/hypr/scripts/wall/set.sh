#!/bin/bash
# swww img -t any --transition-bezier 0.65,-0.31,0.35,1.31 --transition-duration 4 --transition-step 0 --transition-fps 60 "$1"
# hyprctl hyprpaper wallpaper ",$1"
killall swaybg 
swaybg -m fill -i "$1" &
