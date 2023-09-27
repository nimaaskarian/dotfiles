#!/bin/bash

PLAYER_META() {
    if [[ $(playerctl -s metadata artist -p "$1") ]]; then
        playerctl -p "$1" metadata --format '{{artist}} - {{markup_escape(title)}}'
    else 
        playerctl -p "$1" metadata --format '{{markup_escape(title)}}'
    fi
}
PLAYER_STATUS() {
    if [ "$(playerctl -p "$1" status)" == "Playing" ]; then
        echo ""
    else 
        echo ""
    fi
}
output=$(~/.config/hypr/scripts/playerctl.py | while read -r P; do 
echo "$(PLAYER_STATUS $P) $P, $(PLAYER_META "$P")"
done | rofi -dmenu -window-title "   ") &&
printf '%s' "$output" | sed 's/,.*//;s/^.*\s//' > /tmp/player;
