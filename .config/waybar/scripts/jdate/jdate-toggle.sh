#!/bin/bash

[ -f /tmp/jdate ] || touch /tmp/jdate

if [ "$(cat /tmp/jdate )" ]; then printf '' > /tmp/jdate; else printf 1 > /tmp/jdate; fi
