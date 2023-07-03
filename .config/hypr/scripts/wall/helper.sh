#!/bin/bash

cd "$1" || exit
fd -tf . | while read -r A ; do echo -en "$A\x00icon\x1f$1/$A\n";
done
