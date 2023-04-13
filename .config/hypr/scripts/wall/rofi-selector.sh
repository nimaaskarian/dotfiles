#!/bin/bash
dir=$HOME/Pictures/Wallpapers
randkeyword=Random

output=$("$HOME/.config/hypr/scripts/wall/helper.sh" "$dir" "$randkeyword" | rofi -dmenu -show-icons -window-title "" );

[ "$output" ] || exit

if [ "$output" = "$randkeyword" ]; then
  ~/.config/hypr/scripts/wall/rand.sh
else
"$HOME/.local/bin/wal.sh" "$dir/$output"
fi

