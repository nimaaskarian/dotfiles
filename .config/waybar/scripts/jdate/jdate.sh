#!/bin/bash


# $innerfile &
# while inotifywait -q -e close_write /tmp/jdate > /dev/null; do 
#   ps x | pgrep ".*jdate-inside.sh" | while read -r line; do kill "$line"; done;
#   $innerfile &
# done
innerfile="$HOME/.config/waybar/scripts/jdate/jdate-inside.sh"
do_jdate=0
function toggle_do_jdate() {
  if [ $do_jdate -eq 0 ]; then
    do_jdate=1
  else
    do_jdate=0
  fi
}
trap "toggle_do_jdate" USR2

while true; do
  $innerfile $do_jdate 
done
