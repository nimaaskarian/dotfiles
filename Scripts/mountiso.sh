#!/bin/bash

for filename in "$@"
do
  if [ -f "$filename" ]; then
    dir=$HOME/iso/${filename%.*}
    if [ ! -d "$dir" ]; then 
      mkdir "$dir" -p
    fi
    sudo mount -o loop "$filename" "$dir"
    echo $dir | xclip -selection clipboard
     
  fi
done
