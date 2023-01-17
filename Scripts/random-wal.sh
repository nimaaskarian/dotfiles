#!/bin/bash

dir=$1
sleepCount=$2

count=$(ls -1 "$dir" | wc -l)
while true; do
  random=$((1 + "$RANDOM" % count))
  current=1
  echo "$count"
  echo $random
  for wal in "$dir"/*
  do
    if [[ $current -eq $random ]]; then 
      formated_wal=$(echo "$wal" | sed s#//*#/#g)
      echo "$formated_wal"
      wpg -s "$formated_wal"
      break
    fi
    current=$((1+current))
  done
  sleep "$sleepCount"
done
