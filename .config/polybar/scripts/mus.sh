#!/bin/bash

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

cmusOutput=$(player-meta | fribidi | sed 's/  //g')

if [[ $cmusOutput == *Offline* ]]; then
  echo Offline
else
  if [[ $(player-status) == *Playing* ]]; then
    echo " $cmusOutput"
  else 
    echo " $cmusOutput"
  fi
fi


# zscroll --delay 0.5 --length 20 \
#   --match-command "player-status" \
# 	--match-text "Playing" "--before-text ' '" \
# 	--match-text "Paused" "--before-text ' ' --scroll 0" \
# 	-u t "player-meta" &
# wait


# fi
