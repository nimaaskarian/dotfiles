#!/bin/bash

nth=0
waybar_colors_file=~/.cache/wal/colors-waybar.css
color0=$(grep -v 'alpha' $waybar_colors_file | sed 's/.*(//;s/);//' | head -n 1 | sd ',0.75' '')
color7=$(grep -v 'alpha' $waybar_colors_file | sed 's/.*(//;s/);//' | head -n 8 | tail -n 1)
rm ~/log.txt

 grep -v 'alpha' $waybar_colors_file | sed 's/.*(//;s/);//' |
  while read -r l; do
    contrast_ratio0=$(contrast -1 "$color0" -2 "$l")
    contrast_ratio7=$(contrast -1 "$color7" -2 "$l")
    echo $nth, 0: $contrast_ratio0 >> ~/log.txt
    echo $nth, 7: $contrast_ratio7 >> ~/log.txt
    color=$color0

    [ $contrast_ratio7 == 'inf' ] && color=$color7
    (( $(echo "$contrast_ratio7 > $contrast_ratio0" | bc -l) )) && color=$color7

    echo "@define-color foreground$nth rgb($color);" >> $waybar_colors_file
    [ $nth -eq 3 ] && 
      echo "@define-color foreground${nth}_alpha rgba($color,0.75);" >> $waybar_colors_file
    nth=$((nth+1))
  done
