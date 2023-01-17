#!/bin/bash

current=0
current2=0
formated_input=$(echo -n "$1" | sed 's/\//\n\//g')
last=$(echo -n "$formated_input" | wc -l)
echo $last
lastTouch=1
while read -r section; do
  if [ "$section" == "/" ]; then 
    echo c: $current2, l: $last
    if [ $current2 -eq $last ]; then
      lastTouch=0
    else
      echo "> Error: file name can't be empty"
      exit 1
    fi
  fi
  current2=$((current2+1))
done < <(echo "$formated_input")

formated_input=$(echo -n "$formated_input" | sed 's/^\/$//g')
last=$(echo -n "$formated_input" | wc -l)

while read -r section; do
  if [ $current -eq 0 ]; then
    dir="$section"
  else 
    dir=".$section"
  fi
  if [ $lastTouch -eq 1 ] && [ $current -eq $last ]; then
    touch ".$section"
  else 
    if [ ! -d "$section" ]; then 
      mkdir "$dir"
    fi
    cd "$dir"
  fi
  current=$((current+1))
done < <(echo "$formated_input")

cd $pwd
