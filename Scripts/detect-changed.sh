#!/bin/bash

for f in "$1"/*
do
  filename=$(basename "$f")
  md5=$(md5sum "$f" | sed 's/\s.*$//')
  md5_2=$(md5sum "$2/$filename" | sed 's/\s.*$//')

  if [[ "$md5" != "$md5_2" ]]; then
   echo "$filename" 
  fi
done
