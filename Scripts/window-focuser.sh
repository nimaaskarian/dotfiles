#!/usr/bin/env bash

clients=$(hyprctl clients -j)
classes=($(echo $clients | jq '.[] | .class'))
addresses=($(echo $clients | jq '.[] | .address' | tr -d '"'))

selected_index=$(for i in "${!classes[@]}"; do
  striped_class=$(echo ${classes[$i]} | tr -d '"')
[ "$striped_class" ] &&  echo "$striped_class, $(echo $clients | jq '.[] | .title' | head -n $((i+1)) | tail -n 1 | tr -d '"')";
done | rofi -dmenu -format i -i) &&
hyprctl dispatch focuswindow "address:${addresses[$selected_index]}"
