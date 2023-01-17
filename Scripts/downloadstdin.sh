#!/bin/bash

while read -r line
do
  wget "$line"
done < "/dev/stdin"
