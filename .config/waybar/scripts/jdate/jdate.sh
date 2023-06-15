#!/bin/bash

innerfile="$HOME/.config/waybar/scripts/jdate/jdate-inside.sh"

$innerfile &
while inotifywait -q -e close_write /tmp/jdate > /dev/null; do 
  ps x | pgrep ".*jdate-inside.sh" | while read -r line; do kill "$line"; done;
  $innerfile &
done
