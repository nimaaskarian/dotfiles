#!/bin/bash

nth=0
waybar_colors_file=~/.cache/wal/colors-waybar.css
colors_file=~/.cache/wal/colors
color0=$(head -n 1 < $colors_file)
color7=$(head -n 8 < $colors_file | tail -n 1)

 grep -v 'alpha' $waybar_colors_file | sed 's/.*(//;s/);//' |
  while read -r l; do
    contrast_ratio0=$(contrast -1 "$color0" -2 "$l")
    contrast_ratio7=$(contrast -1 "$color7" -2 "$l")
    color=$color0
    (( $(echo "$contrast_ratio7 > $contrast_ratio0" | bc -l) )) && color=$color7

    color=$(ctorgb "$color")
    echo "@define-color foreground$nth rgb($color);" >> $waybar_colors_file
    [ $nth -eq 3 ] && 
      echo "@define-color foreground${nth}_alpha rgba($color,0.75);" >> $waybar_colors_file
    nth=$((nth+1))
  done
