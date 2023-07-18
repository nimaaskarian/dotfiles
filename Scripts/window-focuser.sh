#!/usr/bin/env bash

clients=$(hyprctl clients -j)
classes=($(echo $clients | jq '.[] | .class'))
addresses=($(echo $clients | jq '.[] | .address' | tr -d '"'))

for i in "${!classes[@]}"; do
  striped_class=$(echo ${classes[$i]} | tr -d '"')
  [ "$striped_class" ] || {
    unset 'classes[i]'
    unset 'addresses[i]'
  }
done 
selected_number=$(for i in "${!classes[@]}"; do echo "${classes[$i]}, $(echo $clients | jq '.[] | .title' | head -n $((i+1)) | tail -n 1 | tr -d '"')"; done| rofi -dmenu -format d -i)
hyprctl dispatch focuswindow "address:$(for c in "${addresses[@]}"; do
  echo $c
done | head -n "$selected_number" | tail -n 1)"
