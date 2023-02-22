#!/bin/bash

index=0
for arg in "$@"; do
  if [[ $arg == '-s' ]]; then
    is_ssh=1
  fi
  if [[ "$(printf $arg | sed 's/\/.*//')" != "$arg" ]]; then
    repo_index=$(($index+1))
  fi
  index=$((index+1))
done
echo "${@: -2} ${@:$(($repo_index+1))}}"
base_url="https://github.com/"
if [[ is_ssh -eq 1 ]]; then
  base_url="git@github.com:"
fi
# git clone "$base_url$argv[$repo_index].git"
