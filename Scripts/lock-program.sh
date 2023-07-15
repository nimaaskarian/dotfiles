#!/bin/bash
export TMPDIR=$HOME/.cache/lock-program
ps x | pgrep -f "lock-program.sh $1" | while read -r l; do 
  [ "$l" != $$ ] && kill "$l"
done
tmp=$(fd . "$TMPDIR" -e ".lock-program-$1")

[ "$tmp" ] || tmp=$(date +"%Y-%m-%d.lock-program-$1")


function reset_runtime_with_file() {
  runtime=$(cat "$tmp")
  [ "$runtime" ] || runtime=0
}
function write_time() {
  echo $runtime > "$tmp"
  i=0
}
reset_runtime_with_file
i=0
while true; do 
  sleep 1;
  tmp_new=$(date +"%Y-%m-%d.lock-program-$1")
  if [ "$tmp_new" != "$tmp" ]; then
    reset_runtime_with_file
  fi
  if [ "$(ps -fC "$1" --no-heading)" ]; then
    runtime=$((1+runtime))
    echo $runtime
    [ "$runtime" -gt "$2" ] && {
      killall "$1" 
      write_time
    }
    i=$((i+1))
    [ $i -gt 60 ] && {
      write_time
    }
  fi
done
