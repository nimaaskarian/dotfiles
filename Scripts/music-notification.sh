#!/bin/bash

prevMeta=$(cmus-meta)
prevStatus=$(mus-status)
while true;do 
  status=$(mus-status)
  meta=$(cmus-meta)
  if [ ! "$(< /tmp/player)" == "cmus" ]; then
    if [ ! "$meta" == "$prevMeta" ] || [ ! "$status" == "$prevStatus" ]; then
      prevStatus=$status
      prevMeta=$meta
      dunstify "$status $meta"
    fi
  fi
  sleep 1
done
