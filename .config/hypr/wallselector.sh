#!/bin/bash
dir=$HOME/Pictures/Wallpapers
randkeyword=Random

output=$("$HOME/.config/hypr/wallhelper.sh" "$dir" "$randkeyword" | rofi -dmenu -show-icons -window-title "" );

[[ $output ]] || exit

if [[ $output == "$randkeyword" ]]; then
  ~/.config/hypr/randwall.sh
else
"$HOME/.local/bin/wal.sh" "$dir/$output"
fi

