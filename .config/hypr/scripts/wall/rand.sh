#!/bin/bash
dir=$HOME/Pictures/Wallpapers
fd_args="-tf ."
[ "$1" ] && fd_args="$1"

output=$(fd $fd_args --base-directory="$dir" --exclude="wal_sample" | shuf -n1) &&
"$HOME/.local/bin/wal.sh" "$dir/$output" "$2"
