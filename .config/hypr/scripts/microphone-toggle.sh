#!/bin/bash

pactl set-source-mute @DEFAULT_SOURCE@ toggle 
pactl get-source-mute @DEFAULT_SOURCE@ | while read -r OUTPUT; do
if [ "$OUTPUT" == "Mute: yes" ]; then 
  OUTPUT="Microphone Muted"
else
  OUTPUT="Microphone Unmuted"
fi
dunstify "$OUTPUT" 
done
