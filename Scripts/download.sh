#!/bin/bash

file=0
for arg in "$@"; do 
  if [ "$file" -eq 1 ]; then
    file=$arg
  fi
  if [ "$arg" == "-i" ]; then
    file=1
  fi
done

DOWNLOAD(){
    curl -s "$1" | bsdtar -xf-
  echo INFO: Downloading and extracting "$1"
}

if [ $file -eq 0 ]; then
  for link in "$@"; do 
    DOWNLOAD "$link"
  done
else
  while read -r line; do 
    DOWNLOAD "$line"
  done < $file
fi
