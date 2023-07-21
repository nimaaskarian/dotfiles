#!/bin/bash

trap "write_time_to_file;exit" EXIT

DIR=$HOME/.cache/lock-program
function write_time_to_file() {
  if [ "$runtime" ] && [ "$tmp" ]; then
    echo $runtime > "$tmp" && echo "Wrote to $tmp"
    i=0
  fi
}
function help_options() {
  echo Usage: 
  echo "  lock-program.sh -f <FILENAME> -p <PROCESS NAME> -t <TIME LIMIT> -c <CLASS NAME> -P"
  echo "<FILENAME> is optional. If not specifed, <PROCESS NAME> or <CLASS NAME> will be used instead."
  echo "<TIME LIMIT> is in seconds and its optional. If not specifed, program won't kill the given process"
  echo "<CLASS NAME> will be used instead of <PROCESS NAME> if specifed; in this case <PROCESS NAME> will be used to kill the program."
  echo "-P      print"
  exit 1
}

[ 0 -eq $# ] && {
  help_options
}
time=-1
while getopts "t:f:p:c:P" OPTION; do
    case $OPTION in
    f)
        file_name=$OPTARG
        ;;
    t)
        time=$OPTARG
        ;;
    p)
        process_name=$OPTARG
        ;;
    P)
      print=1
      ;;
    c)
        class_name=$OPTARG
        ;;
    *)
        echo "Incorrect options provided"
        help_options
        ;;
    esac
done

[ "$file_name" ] || {
  if [ "$process_name" ]; then
    file_name=$process_name
  elif [ "$class_name" ]; then
    file_name=$class_name
  else
    help_options
  fi
}
function mktmp() {
  date +"$DIR/%Y-%m-%d.lock-program-$file_name"
}
[ "$print" ] && {
  cat "$(mktmp)"
  exit
}


{
  ps x | pgrep -f "lock-program.sh.*-c $class_name"
  ps x | pgrep -f "lock-program.sh.*-p $process_name"
} | while read -r l; do 
  [ "$l" != $$ ] && kill "$l"
done

function is_active(){
  if [ "$class_name" ]; then
    if [ "$WAYLAND_DISPLAY" ]; then
      [ "$class_name" = "$(hyprctl activewindow | grep class | awk '{print $2}')" ] && printf "%c" 1
    else
      [ "$class_name" = "$(xdotool getactivewindow getwindowclassname)" ] && printf "%c" 1
    fi
  else
    ps -fC "$process_name" --no-heading
  fi
}
function reset_runtime_with_file() {
  cat_content=$(cat "$tmp")
  runtime=${cat_content:-0}
}
tmp=$(mktmp)
reset_runtime_with_file
i=0
while true; do 
  sleep 1;
  if [ "$(mktmp)" != "$tmp" ]; then
    tmp="$(mktmp)"
    reset_runtime_with_file
  fi
  if [ "$(is_active)" ]; then
    runtime=$((1+runtime))
    echo $runtime
    if [ "$runtime" -gt "$time" ] && [ "$time" -ne -1 ]; then 
      killall "$process_name" 
      write_time_to_file
    fi
    i=$((i+1))
    [ $i -gt 60 ] && {
      write_time_to_file
    }
  fi
done
