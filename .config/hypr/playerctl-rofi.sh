#!/bin/bash

PLAYER_FOLLOW() {
    if [[ $(playerctl -s metadata artist -p "$1") ]]; then
        playerctl -p "$1" metadata --format '{{artist}} - {{markup_escape(title)}}'
    else 
        playerctl -p "$1" metadata --format '{{markup_escape(title)}}'
    fi
}

output=$(playerctl -l | while read -r P; do 
title=$(PLAYER_FOLLOW "$P")
echo "$P, $title"
done | rofi -dmenu -window-title "") &&
printf '%s' "$output" | sed 's/,.*//' > /tmp/player;
