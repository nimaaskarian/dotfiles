#!/bin/bash

killall picom
sleep 1
# picom -b --animations --animation-window-mass 0.5 --animation-for-open-window zoom --animation-stiffness 350 
# picom --config ~/.config/picom/picom.conf.noalpha -b
picom -b
