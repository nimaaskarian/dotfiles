#!/bin/bash
dir=$HOME/iso

for arg in "$@"
do
  if [ "$arg" == "-a" ]; then 
    for iso in "$dir"/*
    do 
      echo "$iso"
    done
  else 
    echo "$dir/$arg"
  fi
done
