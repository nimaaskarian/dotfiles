#!/bin/bash
sleep 1
killall xdg-desktop-portal-hyprland
# killall xdg-desktop-portal-wlr
# killall xdg-desktop-portal
# /usr/lib/xdg-desktop-portal-hyprland &

systemctl start xdg-desktop-portal-hyprland --user
# sleep 2
# /usr/lib/xdg-desktop-portal &