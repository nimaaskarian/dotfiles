#!/bin/bash
dir=$HOME/Pictures/Wallpapers
output=$(fd -tf . "$dir" | shuf -n1) &&
"$HOME/.local/bin/wal.sh" "$output"
