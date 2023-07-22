nth=0
waybar_colors_file=~/.cache/wal/colors-waybar.css
color0=$(grep -v 'alpha' $waybar_colors_file | sed 's/.*(//;s/);//' | head -n 1 | sd ',0.75' '')
color7=$(grep -v 'alpha' $waybar_colors_file | sed 's/.*(//;s/);//' | head -n 8 | tail -n 1)
dark_color=$color0
light_color=$color7
[ "$(isdark -c "$color7")" -eq 1 ] && {
  dark_color=$color7 
  light_color=$color0
}

 grep -v 'alpha' $waybar_colors_file | sed 's/.*(//;s/);//' |
  while read -r l; do
    color=$dark_color
    [ "$(isdark -r "$l")" -eq 1 ] && color=$light_color
    echo "@define-color forground$nth rgb($color)" >> $waybar_colors_file
    nth=$((nth+1))
  done
