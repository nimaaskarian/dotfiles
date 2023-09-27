#!/bin/bash
dir=/usr/share/icons
CURSORTHEME=$(fd . --base-directory $dir --max-depth=1 -td | tr -d '/' | sort | tail -n +2 | tofi --prompt-text " Cursor " )

if [ "$CURSORTHEME" = "" ]; then
  exit 1
fi

gsettings set org.gnome.desktop.interface cursor-theme $CURSORTHEME
hyprctl setcursor "$CURSORTHEME" "$(gsettings get org.gnome.desktop.interface cursor-size)"
