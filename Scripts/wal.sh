#!/usr/bin/env bash
# Dependencies:
# python, wpgtk
# wal-telegram
# pywal-discord (and better discord)

previous_theme=$(cat $HOME/.cache/theme_name)
alpha=bf
no_alpha=FF
CONFIG="$HOME/.config"
function set_video_thumbnail() {
  video_thumbnail=$HOME/.cache/wal/thumbnail.png
  rm "$video_thumbnail"
  ffmpegthumbnailer -s 0 -i "$1" -o "$video_thumbnail"
}
# Main
if [[ -f "$(which wal)" ]]; then
	if [[ "$1" ]]; then
    killalll mpvpaper
    file_mimetype=$(mimetype --output-format "%m" "$1")
    [ "$file_mimetype" = "image/gif" ] && set_video_thumbnail "$1"

    if [[ "$file_mimetype" == "video/"* ]] ; then
      set_video_thumbnail "$1"
      hyprctl monitors -j | jq -r ".[].name" | while read -r monitor; do 
        mpvpaper "$monitor" "$1" -o "--loop=inf --mute=yes" &
      done  
    else
      [ "$WAYLAND_DISPLAY" ] && ~/.config/hypr/scripts/wall/set.sh "$1"
    fi

		printf '%s' "$2" > "$HOME/.cache/theme_name"
		printf '%s' "$1" > "$HOME/.cache/wallpaper_path"
		if [ "$2" ]; then
			# no reload if theme hasn't changed
			wal --theme "$2"
      wpg -Ti "$1" "$2"
      wpg -s "$1"
		else
			wal -i "$1"
      # wpg -s "$1"
		fi
    wpg -i "$1" "$HOME/.cache/wal/colors-wpg.json"
    wpg -s "$1"
			
    if [ "$video_thumbnail" ]; then
      wal-telegram --background "$video_thumbnail"
    else
      wal-telegram --background "$1"
    fi
    [ "$2" ] && [ "$previous_theme" = "$2" ] && exit 

		. "$HOME/.cache/wal/colors.sh"

    # gradients for cava file
    sed -i '/gradient_color/d' ~/.config/cava/config
    i=1
    {
    echo $color2
    echo $color3
    echo $color1
  } | uniq | while read -r l; do 
      echo gradient_color_$i = \'$l\';i=$((i+1)); 
    done >> ~/.config/cava/config
    pkill -USR2 cava
    ~/Scripts/change-waybar-colors-dark.sh
		~/Scripts/pywal-obsidianmd.sh "$HOME/Documents/Obsidian Notes/main"
		# ~/.suckless/cpwal.sh
		
		~/Scripts/discord-pywal/make.sh
		pywal-discord
		# cp "$HOME/.cache/wal/colors" ~/Documents/Front\ End/nitab-pro/build/

    sed -i -e "s/\$background #.*/\$background #$(echo $background | tr -d "#")$alpha/g" "$CONFIG/i3/config" 
		sed -i 's/:root.*//gi' "$CONFIG/qutebrowser/pywal.css"
	  tr -d '\n' < /home/nima/.cache/wal/colors.css | sed 's/.*:root/:root/gi' >> "$CONFIG/qutebrowser/pywal.css"
		sed -i "s+span.*color=.*'>+span color='$color2'>+g" "$CONFIG/waybar/config" 
		~/Scripts/xournalpp-backgroundcolor.py
		# Associative array, color name -> color code.
		declare -A makocolors

    mako_background=$color2
    mako_text=$color0

    contrast_ratio0=$(contrast -1 "$color0" -2 "$mako_background")
    contrast_ratio7=$(contrast -1 "$color7" -2 "$mako_background")
    (( $(echo "$contrast_ratio7 > $contrast_ratio0" | bc -l) )) && mako_text=$color7

		makocolors=(
				["background-color"]="$mako_background"
				["text-color"]="$mako_text"
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
