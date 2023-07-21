#!/usr/bin/env bash
# Dependencies:
# python, wpgtk
# wal-telegram
# pywal-discord (and better discord)

previous_theme=$(cat $HOME/.cache/theme_name)
alpha=bf
no_alpha=FF
CONFIG="$HOME/.config"
# Main
if [[ -f "$(which wal)" ]]; then
	if [[ "$1" ]]; then
		[ "$WAYLAND_DISPLAY" ] && ~/.config/hypr/scripts/wall/set.sh "$1"

		printf '%s' "$2" > "$HOME/.cache/theme_name"
		printf '%s' "$1" > "$HOME/.cache/wallpaper_path"
		if [ "$2" ]; then
			# no reload if theme hasn't changed
			wal --theme $2
			wpg -i "$1" "$HOME/.cache/wal/colors-wpg.json"
			wpg -s "$1"
			[ "$previous_theme" = "$2" ] && {
				wal-telegram --background "$1"
				exit 
			}
		else
			wal -i "$1"
			wpg -i "$1" "$HOME/.cache/wal/colors-wpg.json"
		fi

		wal-telegram --background "$1"
		~/Scripts/pywal-obsidianmd.sh "$HOME/Documents/Obsidian Notes/main"
		# ~/.suckless/cpwal.sh
		
		~/Scripts/discord-pywal/make.sh
		pywal-discord
		. "$HOME/.cache/wal/colors.sh"
		# cp "$HOME/.cache/wal/colors" ~/Documents/Front\ End/nitab-pro/build/

		rm ~/Documents/Front\ End/nitab-vanilla/css/colors.css
		cp ~/.cache/wal/colors.css "$HOME/Documents/Front End/nitab-vanilla/css" -f
    sed -i -e "s/\$background #.*/\$background #$(echo $background | tr -d "#")$alpha/g" "$CONFIG/i3/config" 
		sed -i 's/:root.*//gi' "$CONFIG/qutebrowser/pywal.css"
	  tr -d '\n' < /home/nima/.cache/wal/colors.css | sed 's/.*:root/:root/gi' >> "$CONFIG/qutebrowser/pywal.css"
		sed -i "s+span.*color=.*'>+span color='$color2'>+g" "$CONFIG/waybar/config" 
		~/Scripts/xournalpp-backgroundcolor.py
		# Associative array, color name -> color code.
		declare -A makocolors
		makocolors=(
				["background-color"]="${background}${alpha}"
				["text-color"]="$foreground"
				["border-color"]="$color2"
		)

		for color_name in "${!makocolors[@]}"; do
			# replace first occurance of each color in config file
			sed -i "0,/^$color_name.*/{s//$color_name=${makocolors[$color_name]}/}" "$CONFIG/mako/config"
		done

		# reloading
		makoctl reload
		killall waybar
		waybar & disown
		killall discord-screenaudio && discord-screenaudio &>/dev/null & disown 
		killall Discord && discord &>/dev/null & disown 
		i3-msg restart
		killall dunst
		killall mpd-notification && mpd-notification -m ~/Music &>/dev/null & disown
	else
		echo -e "[!] Please enter the path to wallpaper. \n"
		echo "Usage : ./wal.sh path/to/image"
	fi
else
	echo "[!] 'pywal' is not installed."
fi
