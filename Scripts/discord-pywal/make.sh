#!/bin/bash

current_dir=$(dirname "$0")
file="$current_dir/discord-pywal.css"
cat ~/.cache/wal/colors.css > "$file"
cat "$current_dir/pywal-discord-default.css" >> "$file"

cp "$file" ~/.config/discord-screenaudio/userstyles.css
