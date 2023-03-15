#!/bin/python3
import os
from re import sub
colors_path = os.path.expanduser("~/.cache/wal/colors")

f = open(colors_path,"r")
color = f.read().splitlines()[0][1:]
f.close()
decimal_value = int(color[1:], 16)

xournalconfig_path = os.path.expanduser("~/.config/xournalpp/settings.xml")

f = open(xournalconfig_path, "r")
config_data = f.read()
f.close()

string = "idk"
config_lines = config_data.splitlines()
for line in config_lines:
    if 'backgroundColor" value=' in line:
        line = sub('value=".*"',f'value="{decimal_value}"',line)
config_data_changed = "\n".join(config_lines)
print(config_data_changed)
f = open(xournalconfig_path, "w")
f.write(config_data_changed)



