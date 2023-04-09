#!/bin/bash

[[ ! -f /tmp/player ]] && player
c_player=$(</tmp/player)
l_player=$c_player

PLAYER_FOLLOW() {
    if [[ $(playerctl -s metadata artist -p "$1") ]]; then
        playerctl -p "$1" metadata --format '{"text": "{{artist}} - {{markup_escape(title)}}", "tooltip": "{{playerName}} : {{artist}} - {{markup_escape(title)}}", "alt": "{{status}}", "class": "{{status}}"}' -F &
    else 
        playerctl -p "$1" metadata --format '{"text": "{{markup_escape(title)}}", "tooltip": "{{playerName}} : {{artist}} - {{markup_escape(title)}}", "alt": "{{status}}", "class": "{{status}}"}' -F &
    fi
}
PLAYER_FOLLOW "$c_player"
while inotifywait -q -e close_write /tmp/player > /dev/null; do 
    c_player=$(</tmp/player)
    killall -q playerctl
    if [[ "$l_player" != "$c_player" ]]; then
        l_player=$c_player
        PLAYER_FOLLOW "$c_player"
    fi
done 

#prepend_zero () {
#    seq -f "%02g" $1 $1
#}

# artist=$(echo -n $(cmus-remote -C status | grep artist -m 1| cut -c 12-))
# song=$(echo -n $(cmus-remote -C status | grep title | cut -c 11-))

#position=$(cmus-remote -C status | grep position | cut -c 10-)
#minutes1=$(prepend_zero $(($position / 60)))
#seconds1=$(prepend_zero $(($position % 60)))

#duration=$(cmus-remote -C status | grep duration | cut -c 10-)
#minutes2=$(prepend_zero $(($duration / 60)))
#seconds2=$(prepend_zero $(($duration % 60)))
# if [ -z "$(playerctl metadata title)" ]
# then
	 # echo -n "Offline" 
# else
# if [[ $cmusOutput == *Offline* ]]; then
#   echo '{"text":""}'
# else
#   if [[ $(~/Scripts/player-status.sh) == *Playing* ]]; then
#       echo '{"text":"$cmusOutput", "class":"playing"}'
#   else 
#       echo '{"text":"$cmusOutput", "class":"paused"}'
#   fi
# fi


# zscroll --delay 0.5 --length 20 \
#   --match-command "player-status" \
# 	--match-text "Playing" "--before-text ' '" \
# 	--match-text "Paused" "--before-text ' ' --scroll 0" \
# 	-u t "player-meta" &
# wait
