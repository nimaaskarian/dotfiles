#!/usr/bin/env bash
# Dependencies:
# python, wpgtk
# wal-telegram
# pywal-discord (and better discord)

alpha=bf

# Main
if [[ -f "$(which wal)" ]]; then
	if [[ "$1" ]]; then
		wpg -s "$1"
		wal-telegram -r
		pywal-discord
    # cp ~/.cache/wal/colors-zathura ~/.config/zathura/zathurarc
    cp ~/.cache/wal/colors-flameshot.ini ~/.config/flameshot/flameshot.ini

		# change i3s wallpaper config
		printf '%s' "$1" > /home/nima/.wallpaper_path
		# sed -i -e 's@set $wallpaper .*@set $wallpaper '"$1"'@g' "$HOME"/.config/i3/config		

		# Source the pywal color file
		. "$HOME/.cache/wal/colors.sh"
		cp "$HOME/.cache/wal/colors" ~/Documents/Front\ End/nitab-pro/build/
    sed -i -e "s/\$background #.*/\$background #$(echo $background | tr -d "#")$alpha/g" "$HOME/.config/i3/config" 
		sed -i 's/:root.*//gi' "$HOME/.config/qutebrowser/pywal.css"
	  tr -d '\n' < /home/nima/.cache/wal/colors.css | sed 's/.*:root/:root/gi' >> "$HOME/.config/qutebrowser/pywal.css"

		# sync xournalpp background to pywal
		~/Scripts/xournalpp-backgroundcolor.py
    # sed -i -e 's/background = "#.*"/background = "'"#$(echo $background | tr -d "#")$alpha"'"/g' "$HOME/.cache/wal/colors-dunst"
    # sed -i -e 's/"border-rgba": ".*"/"border-rgba": "'"0x$(echo $color2 | tr -d "#")$alpha"'"/g' "$HOME/.config/xborder/config.json"

    # restart services then call betterlockscreen
    # killall xborders
     # ~/Scripts/run-to-nowhere.sh xborders -c "$HOME/.cache/wal/colors-xborders.json"

    i3-msg restart
    killall dunst
    # nohup dunst -config ~/.cache/wal/colors-dunst &
    cp ~/.cache/wal/stalonetrayrc ~/.config
    betterlockscreen -u "$1" --blur 1.0 --dim 55
		killall mpd-notification
		nohup mpd-notification -m ~/Music > /dev/null &
	else
		echo -e "[!] Please enter the path to wallpaper. \n"
		echo "Usage : ./wal.sh path/to/image"
	fi
else
	echo "[!] 'pywal' is not installed."
fi
