#!/bin/bash

warpindex=$(warp-cli status | wc -c)
if [ "$warpindex" -eq 33 ]
then
  echo "%{A1:warp-cli disconnect &:} C%{A}"
elif [ "$warpindex" -eq 36 ]
  then
  echo "%{A1:warp-cli connect &:} DC%{A}"
elif [ "$warpindex" -eq 34 ]
  then
  echo "%{A1:warp-cli disconnect &:} Cing%{A}"
fi
