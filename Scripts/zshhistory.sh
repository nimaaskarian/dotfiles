#!/bin/bash

his=$HOME/.cache/zsh_history
mv "$his" "${his}_old"
strings "${his}_old" > "$his"
fc -r "$his"
rm "${his}_old"
