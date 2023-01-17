#!/bin/bash

lynx "$1" -dump | grep  -E -i -w 'mkv|mp4' | sed 's/^.*\s//'
