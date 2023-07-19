#!/bin/bash
dir=$HOME/Pictures/Wallpapers

cd "$dir" || exit

output=$(fd -tf . | grep -v "wal_sample"  | while read -r A ; do echo -en "$A\x00icon\x1f$dir/$A\n"; done | rofi -l 0 -i -dmenu -show-icons -window-title "" );
[ "$output" ] || exit

random() {
  theme=$(get_theme)
  fd_cmd=$1
  [ "$1" ] || fd_cmd=$(rofi -dmenu -l 0 -i -mesg "Type random selection fd arguments [-tf .]" -window-title "")
  ~/.config/hypr/scripts/wall/rand.sh "$fd_cmd" "$theme"
}

get_theme() {
  ~/.config/hypr/scripts/wall/theme-selector.py
}
if [[ "$output" == "rand"* ]]; then
  random
else
  if [ -f "$dir/$output" ]; then
    theme=$(get_theme)
    "$HOME/.local/bin/wal.sh" "$dir/$output" "$theme"
  else 
    [[ $output == "fd "* ]] && {
      output=$(printf "%s" "$output" | sd "^fd " "")
      random "$output"
    }
  fi
fi

