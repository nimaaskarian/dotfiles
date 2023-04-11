#!/bin/sh

jdate '+%d %V' | sed 's/0/۰/g;s/1/۱/g;s/2/۲/g;s/3/۳/g;s/4/۴/g;s/5/۵/g;s/6/۶/g;s/7/۷/g;s/8/۸/g;s/9/۹/g'
