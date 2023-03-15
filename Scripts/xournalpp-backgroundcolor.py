#!/bin/python3
import os
from re import sub
colors_path = os.path.expanduser("~/.cache/wal/colors")
def hex_to_dec(hex_code):
    base_value = 255 << 24
    decimal_value = int(hex_code[1:], 16)
    result = decimal_value+base_value
    return result

f = open(colors_path,"r")
color = f.read().splitlines()[0]
f.close()
decimal_value = hex_to_dec(color)
# print(decimal_value)
# exit()
xournalconfig_path = os.path.expanduser("~/.config/xournalpp/settings.xml")

f = open(xournalconfig_path, "r")
config_data = f.read()
f.close()

config_lines = []
for line in config_data.splitlines():
    if 'backgroundColor" value=' in line:
        line = sub('value=".*"',f'value="{decimal_value}"',line)
        print(line)
    config_lines.append(line)
config_data_changed = "\n".join(config_lines)
# print(config_data_changed,end="")
f = open(xournalconfig_path, "w")
f.write(config_data_changed)
f.close()
