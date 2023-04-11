#!/bin/bash
dir=$HOME/Pictures/Wallpapers
cd "$dir" || exit
output=$(fd -tf . | while read -r A ; do echo -en "$A\x00icon\x1f$dir/$A\n";
done | rofi -dmenu -show-icons) &&

"$HOME/.local/bin/wal.sh" "$dir/$output" 
