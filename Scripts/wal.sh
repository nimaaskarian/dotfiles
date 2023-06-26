#!/usr/bin/env bash
# Dependencies:
# python, wpgtk
# wal-telegram
# pywal-discord (and better discord)

alpha=bf
no_alpha=FF
CONFIG="$HOME/.config"
# Main
if [[ -f "$(which wal)" ]]; then
	if [[ "$1" ]]; then

		if [ "$2" ]; then
			wpg -Ti $1 $2 -s $1
			wal --theme "$2"
		else
			wpg -n -s "$1"
		fi

		[ "$WAYLAND_DISPLAY" ] && ~/.config/hypr/scripts/wall/set.sh "$1"
		~/Scripts/pywal-obsidianmd.sh "$HOME/Documents/Obsidian Notes/main"
		# ~/.suckless/cpwal.sh
		
		wal-telegram -r --background "$1"
		pywal-discord
    # cp ~/.cache/wal/colors-zathura ~/.config/zathura/zathurarc

		# change i3s wallpaper config
		printf '%s' "$1" > "$HOME/.cache/wallpaper_path"
		# sed -i -e 's@set $wallpaper .*@set $wallpaper '"$1"'@g' "$HOME"/.config/i3/config		

		# Source the pywal color file
		. "$HOME/.cache/wal/colors.sh"
		# cp "$HOME/.cache/wal/colors" ~/Documents/Front\ End/nitab-pro/build/
		rm ~/Documents/Front\ End/nitab-vanilla/css/colors.css
		cp ~/.cache/wal/colors.css "$HOME/Documents/Front End/nitab-vanilla/css" -f


	# declare -A hyprcolors
	# 	hyprcolors=(
	# 			["col.group_border"]="$(echo $color0 | tr -d "#")$alpha"
	# 			["col.group_border_active"]="$(echo $color7 | tr -d "#")$no_alpha"
	# 			["col.inactive_border"]="$(echo $color0 | tr -d "#")$alpha"
	# 			["col.active_border"]="$(echo $color7 | tr -d "#")$no_alpha"
	# 	)
	# for color_name in "${!hyprcolors[@]}"; do
		# replace first occurance of each color in config file
	# 	sed -i "0,/$color_name =.*/{s//$color_name = rgba(${hyprcolors[$color_name]})/}" "$CONFIG/hypr/hyprland.conf"
	# done
		
    sed -i -e "s/\$background #.*/\$background #$(echo $background | tr -d "#")$alpha/g" "$CONFIG/i3/config" 
		sed -i 's/:root.*//gi' "$CONFIG/qutebrowser/pywal.css"
	  tr -d '\n' < /home/nima/.cache/wal/colors.css | sed 's/.*:root/:root/gi' >> "$CONFIG/qutebrowser/pywal.css"
		sed -i "s+span.*color=.*'>+span color='$color2'>+g" "$CONFIG/waybar/config" 
		killall waybar
		waybar &disown
		# swaybg -m fill -i "$(< ~/.wallpaper_path)" &> /dev/null &
		# sync xournalpp background to pywal
		~/Scripts/xournalpp-backgroundcolor.py
    # sed -i -e 's/background = "#.*"/background = "'"#$(echo $background | tr -d "#")$alpha"'"/g' "$HOME/.cache/wal/colors-dunst"
    # sed -i -e 's/"border-rgba": ".*"/"border-rgba": "'"0x$(echo $color2 | tr -d "#")$alpha"'"/g' "$CONFIG/xborder/config.json"

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

	makoctl reload
    # restart services then call betterlockscreen
    # killall xborders
     # ~/Scripts/run-to-nowhere.sh xborders -c "$HOME/.cache/wal/colors-xborders.json"

    i3-msg restart
    killall dunst
		# [[ $(ps -e | rg Hyprland | wc -c) == "0" ]] && killall dunst;nohup dunst -conf /home/nima/.cache/wal/colors-dunst-hyprland &> /dev/null & 
    # nohup dunst -config ~/.cache/wal/colors-dunst &
		killall mpd-notification
		mpd-notification -m ~/Music &disown
    # betterlockscreen -u "$1" --blur 1.0 --dim 55
	else
		echo -e "[!] Please enter the path to wallpaper. \n"
		echo "Usage : ./wal.sh path/to/image"
	fi
else
	echo "[!] 'pywal' is not installed."
fi
