#!/bin/bash
swww img -t outer --transition-bezier 0.25,0.5,0.1,1.05 --transition-duration 4 --transition-step 90 --transition-fps 60 "$1"
# hyprctl hyprpaper wallpaper ",$1"
# killall swaybg 
# swaybg -m fill -i "$1" &
