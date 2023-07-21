#!/bin/bash

tmpfile=$(mktemp --suffix "-edit-batch-rm-pacman")
constfile=$(mktemp --suffix "-const-batch-rm-pacman")
pacman -Qe > "$tmpfile"
pacman -Qe > "$constfile"
chmod -w "$constfile"
$EDITOR "$tmpfile"
remove=$(grep -Fvxf "$tmpfile" "$constfile" | awk '{print $1}')
install=$(grep -Fvxf "$constfile" "$tmpfile")
if [ "$remove" ] && [[ "$install" != *$remove* ]]; then
  echo "Are you sure you want to remove these packages?"
  while read -r l; do
    [[ "$install" = *$l* ]] && continue
    echo $l | cut -f 2 -d ' '| tr '\n' ' ' 
  done <<< "$remove"
  read -rp "(Y/n) " userinput
  case $userinput in
    n | N)
      ;;
    *)
      sudo pacman -Rs $remove --noconfirm
      ;;
  esac
fi

if [ "$install" ]; then
  packages=""
  urls=""
  while read -r l; do
    [ "$l" ] || continue

    package=$(printf "%s" "$l" | cut -f 1 -d ' ')
    version=$(printf "%s" "$l" | cut -f 2 -d ' ' -s)
    [ "$version" ] || { 
        packages+="$package" 
        continue
      }
    first_letter=$(printf '%c' "$package")

    pkg_zst_url=$(lynx --dump --listonly --nonumbers --display_charset=utf-8 \
      "https://archive.archlinux.org/packages/$first_letter/$package" | grep "zst$" | grep "$package-$version" | fzf)

    [ "$pkg_zst_url" ] || continue

    urls+=" $pkg_zst_url"
    
  done <<< "$install"
  [ "$packages" ] && sudo pacman -S $packages
  [ "$urls" ] && sudo pacman -U $urls
fi
echo Quitting...
