#!/bin/bash
is_persian=""

hyprctl devices | grep Persian &> /dev/null && {
  is_persian=true
  hyprctl switchxkblayout my-kmonad-output 0 &> /dev/null
}

eval "$*" 
[ "$is_persian" = true ] && {
  hyprctl switchxkblayout my-kmonad-output 1 &> /dev/null
}
