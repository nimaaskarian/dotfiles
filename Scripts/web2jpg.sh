#!/bin/bash

if [ -f "$1" ]; then
  output=${1%.*}.jpg
  magick "$1" "$output"
fi
