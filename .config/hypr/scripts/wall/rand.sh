#!/bin/bash
dir=$HOME/Pictures/Wallpapers
cmd="$*"
[ "$cmd" ] || cmd="fd -tf ."

output=$($cmd "$dir" | shuf -n1) &&
"$HOME/.local/bin/wal.sh" "$output"
