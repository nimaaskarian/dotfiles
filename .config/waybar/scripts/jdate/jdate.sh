#!/bin/bash


# $innerfile &
# while inotifywait -q -e close_write /tmp/jdate > /dev/null; do 
#   ps x | pgrep ".*jdate-inside.sh" | while read -r line; do kill "$line"; done;
#   $innerfile &
# done
innerfile="$HOME/.config/waybar/scripts/jdate/jdate-inside.sh"
MAX=3
MIN=0
do_jdate=$MIN
function do_jdate_increase() {
  do_jdate=$((do_jdate+1))
  [ $do_jdate -gt $MAX ] && do_jdate=$MIN
}
function do_jdate_decrease() {
  do_jdate=$((do_jdate-1))
  [ $do_jdate -lt $MIN ] && do_jdate=$MAX
}
trap "do_jdate_increase" USR2
trap "do_jdate_decrease" USR1

while true; do
  $innerfile $do_jdate 
done
