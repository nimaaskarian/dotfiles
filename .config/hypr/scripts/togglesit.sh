if [ "$(ps x | pgrep sitdowntimer)" ]; then
  notify-send "Sit down timer ended!"
  killall sitdowntimer
else
  notify-send "Sit down timer started!"
  sitdowntimer 
fi
