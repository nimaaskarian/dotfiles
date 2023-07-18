#!/bin/bash
dir=$HOME/Pictures/Wallpapers

cd "$dir" || exit

output=$(fd -tf . | grep -v "wal_sample"  | while read -r A ; do echo -en "$A\x00icon\x1f$dir/$A\n"; done | rofi -l 0 -i -dmenu -show-icons -window-title "" );
[ "$output" ] || exit

random() {
  fd_cmd=$1
  [ "$1" ] || fd_cmd=$(rofi -dmenu -l 0 -i -mesg "Type random selection fd arguments [-tf .]" -window-title "")
  ~/.config/hypr/scripts/wall/rand.sh "$fd_cmd" "$2"
}


if [[ "$output" == "rand"* ]]; then
  random
else
  theme=$(rofi -dmenu -l 0 -i -mesg "Type theme name:" -window-title "")
  if [ -f "$dir/$output" ]; then
    "$HOME/.local/bin/wal.sh" "$dir/$output" "$theme"
  else 
    [[ $output == "fd "* ]] && {
      output=$(printf "%s" "$output" | sd "^fd " "")
      random "$output" "$theme"
    }
  fi
fi

