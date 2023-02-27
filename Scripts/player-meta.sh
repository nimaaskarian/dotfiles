#!/bin/bash
# if [[ $(cat /tmp/player | wc -c) -eq 0 ]]; then
#   node /home/nima/player -n -s
# fi
if [ -f /tmp/player ]; then 
  if [[ $(wc -c < /tmp/player) -eq 0 ]]; then
    echo Offline
  else 
    if [ $(playerctl -s -l | wc -c) -eq 0 ]
    then
      echo Offline
    else
      if [[ $(playerctl -s metadata artist -p "$(< /tmp/player)") ]]; then
        output="$(playerctl -s metadata --format "{{artist}} - {{title}}" -p "$(< /tmp/player)")"
      else
        output="$(playerctl -s metadata title -p "$(< /tmp/player)")"
      fi
      if [ $(echo -n $output | wc -c) -eq 0 ]; then
        echo Offline
      else 
        echo -n "$output"
      fi
    fi
  fi
else 
  echo Offline
fi
