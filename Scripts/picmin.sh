#!/bin/bash

if [ -f "$1" ]; then
  filename=$(basename -- $1)
  extension=${filename##*.}
  filename=${filename%.*}
  output=$filename-min.$extension
  if [ "$2" ]; then
    magick "$1" -resize "$2" "$output"
  else 
    magick "$1" -resize 2000 "$output"
  fi
fi
