#!/bin/bash

options="-td"
if [ $OPTIONS ]; then options=$OPTIONS; fi
dir=$HOME
while getopts ":H" o; do
    case "${o}" in
        H)
            options+=" -H"
            ;;
        *)
            ;;
    esac
done
shift $((OPTIND-1))
[ $1 ] && dir=$1
output=$(fd $options --base-directory "$dir"| fzf) && echo "$dir/$output"
