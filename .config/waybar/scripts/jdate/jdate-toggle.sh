#!/bin/bash

# [ -f /tmp/jdate ] || touch /tmp/jdate

# if [ "$(cat /tmp/jdate )" ]; then printf '' > /tmp/jdate; else printf 1 > /tmp/jdate; fi
if [ "$1" -eq 1 ]; then
  pkill -USR1 "jdate.sh" 
else
  pkill -USR2 "jdate.sh" 
fi

pkill "jdate-inside.sh" 
