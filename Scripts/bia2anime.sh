#!/bin/bash
resolution=720
if [ "$2" ]; then resolution=$2; fi
lynx "https://bia2anime.fun/series/$1" -dump | grep "$resolution" | sed 's/^.*\s//'
