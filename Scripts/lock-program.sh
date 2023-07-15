#!/bin/bash
DIR=$HOME/.cache/lock-program
[ 0 -eq $# ] && {
  echo Usage: 
  echo "  lock-program.sh name seconds"
  echo "  lock-program.sh 'binary name;process name' seconds"
  exit 1
}
binary_name=$(printf "%s" "$1" | cut -d ';' -f 1)
process_name=$(printf "%s" "$1" | cut -d ';' -f 2)

ps x | pgrep -f "lock-program.sh $binary_name" | while read -r l; do 
  [ "$l" != $$ ] && kill "$l"
done

function mktmp() {
  date +"$DIR/%Y-%m-%d.lock-program-$binary_name"
}
function reset_runtime_with_file() {
  runtime=$(cat "$tmp")
  [ "$runtime" ] || runtime=0
}
function write_time() {
  echo $runtime > "$tmp" && echo "Wrote to $tmp"
  i=0
}
tmp=$(mktmp "$@")
reset_runtime_with_file
i=0
while true; do 
  sleep 1;
  if [ "$(mktmp "$@")" != "$tmp" ]; then
    reset_runtime_with_file
  fi
  if [ "$(ps -fC "$process_name" --no-heading)" ]; then
    runtime=$((1+runtime))
    echo $runtime
    [ "$runtime" -gt "$2" ] && {
      killall "$process_name" 
      write_time
    }
    i=$((i+1))
    [ $i -gt 30 ] && {
      write_time
    }
  fi
done
