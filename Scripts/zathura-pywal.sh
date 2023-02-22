#!/bin/sh

colors_file="$HOME/.cache/wal/colors"
nohup zathura $@ > log.txt 2>&1 &
pid=$!

inotifywait -q -m -e close_write "$colors_file" |
while read -r filename event; do
  kill "$pid"
  nohup zathura $@ > log.txt 2>&1 &
  pid=$!
done
  
