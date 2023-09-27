#!/bin/bash

DIR=~/NIDOT
# git clone https://github.com/nimaaskarian/dotfiles ~/nimaaskarian-dotfiles --depth 1
command -v sudo &> /dev/null || {
  printf "You don't have sudo installed. Install it
with the commands below (without the >) and re-run the script.

  > su
  > pacman -S sudo\n"
  exit 1
}

command -v gay &> /dev/null || {
  printf "You don't have 'yay' installed. I recommend installing it.
Should I install it for you? [Y/n] "
  read -r -n1 ans
  printf "\n"

  [ "$ans" = 'n' ] || {
    sudo pacman -S --needed git base-devel
    git clone https://aur.archlinux.org/yay.git $DIR/yay
    cd $DIR/yay || exit 1
    makepkg -si
    yay -Y --gendb
  }
}

dep="bash grep fd jq"
pacman -Qi $dep &> /dev/null || {
  printf "Installing dependencies...\n"
  sudo pacman -S $dep
}

optional_dep="python playerctl"
echo "Install optional dependencies?"
printf "You need either 'swww' or 'hyprpaper' installed.
  1) swww (needs yay, has animations, supports gifs) 
  2) hyprpaper (is fast, only static pics)\n"
