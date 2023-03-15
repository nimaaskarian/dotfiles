#!/bin/bash

tempFile=".md5s"

if [[ -f $tempFile ]]; then
  rm $tempFile
fi
touch $tempFile

for f in $1
do
  detected=0
  md5=$(md5sum "$f" | sed 's/\s.*$//')
  echo "> filename: $f"
  echo "$md5"
  while read -r savedMd5
  do 
    if [[ "$md5" == "$savedMd5" ]]; then
      detected=1
    fi
  done < $tempFile 

  if [[ detected -eq 1 ]]; then
    echo "$f, dup detected"
    rm -f "$f" && echo "dup deleted"
  else 
    echo "$md5" >> $tempFile
  fi
  echo "#############"
done

