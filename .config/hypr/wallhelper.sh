#!/bin/bash

randc="$2\x00icon\x1f/home/nima/Pictures/Icons/fontawesome-pro-6.1.1-desktop/svgs/regular/dice-six.svg\n"
cd "$1" || exit
echo -en "$randc"
fd -tf . | while read -r A ; do echo -en "$A\x00icon\x1f$1/$A\n";
done
