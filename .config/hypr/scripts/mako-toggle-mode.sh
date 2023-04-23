#!/bin/bash
for l in $(makoctl mode); do 
if [ "$l" == "$1" ]; then 
  # mode found
  found=true
fi
done

if [ "$found" ]; then 
  makoctl mode -r "$1"
else
  makoctl mode -a "$1"
fi
