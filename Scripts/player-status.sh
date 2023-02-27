#!/bin/bash
if [[ $(wc -c < /tmp/player) -eq 0 ]]; then
  echo Offline
else
  echo -n "$(playerctl -s status -p "$(< /tmp/player)")"
fi
