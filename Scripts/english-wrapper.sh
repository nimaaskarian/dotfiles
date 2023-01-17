#!/bin/bash
prev=$(xkb-switch)
xkb-switch -s us
"$@"
xkb-switch -s "$prev"
