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
  echo "  lock-program.sh -f <FILENAME> -p <PROCESS NAME> -t <TIME LIMIT> -c <CLASS NAME>"
  echo "<FILENAME> is optional. If not specifed, <PROCESS NAME> or <CLASS NAME> will be used instead."
  echo "<TIME LIMIT> is in seconds and its optional. If not specifed, program won't kill the given process"
  echo "<CLASS NAME> will be used instead of <PROCESS NAME> if specifed; in this case <PROCESS NAME> will be used to kill the program."
  exit 1
}

[ 0 -eq $# ] && {
  help_options
}
time=-1
while getopts "t:f:p:c:" OPTION; do
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
    c)
        class_name=$OPTARG
        ;;
    *)
        echo "Incorrect options provided"
        exit 1
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



{
  ps x | pgrep -f "lock-program.sh.*-c $class_name"
  ps x | pgrep -f "lock-program.sh.*-p $process_name"
} | while read -r l; do 
  [ "$l" != $$ ] && kill "$l"
done

function is_active(){
  if [ "$class_name" ]; then
    [ "$class_name" = "$(hyprctl activewindow | grep class | sd 'class: ' '' | awk '{print $1}')" ] && echo TRUE
  else
    ps -fC "$process_name" --no-heading
  fi
}
function mktmp() {
  date +"$DIR/%Y-%m-%d.lock-program-$file_name"
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
    [ $i -gt 30 ] && {
      write_time_to_file
    }
  fi
done
