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
colors = f.read().splitlines()
f.close()
# print(decimal_value)
# exit()
xournalconfig_path = os.path.expanduser("~/.config/xournalpp/settings.xml")

f = open(xournalconfig_path, "r")
config_data = f.read()
f.close()

config_lines = []
# name_is_default=False
for line in config_data.splitlines():
    if 'backgroundColor" value=' in line:
        line = sub('value=".*"',f'value="{hex_to_dec(colors[0])}"',line)
        print(line)
    if 'selectionBorderColor" value=' in line:
        line = sub('value=".*"',f'value="{hex_to_dec(colors[7])}"',line)
        print(line)
    # if 'pageTemplate" value=' in line:
    #     line = sub('backgroundColor=.*&',f'backgroundColor=#ff{colors[0][1:]}&',line)
    #     print(line)
    # if 'name="default"' in line:
    #     name_is_default = True
    # if 'attribute name="color" type="hex" value=' in line and name_is_default:
    #     line = sub('value=".*"',f'value="ff{colors[7][1:]}"',line)
    #     name_is_default = False
    #     print(line)
    config_lines.append(line)
config_data_changed = "\n".join(config_lines)
# print(config_data_changed,end="")
f = open(xournalconfig_path, "w")
f.write(config_data_changed)
f.close()
