#!/bin/python3

import os, subprocess, json

themes = os.popen("wal --theme | sed 's/\x1B\[[0-9;]\{1,\}[A-Za-z]//g;s/^ - //g'").read().splitlines()
if "User Themes:" in themes:
    user_themes = themes[themes.index("User Themes:")+1:themes.index("Dark Themes:")]
else:
    user_themes= []

dark_themes = themes[themes.index("Dark Themes:")+1:themes.index("Light Themes:")]
light_themes = themes[themes.index("Light Themes:")+1:themes.index("Extra:")]
random_themes = ["random",  "random_dark","random_light"]
rofi_process = subprocess.Popen(["rofi","-sep","\x0f","-dmenu","-format","i","-i","-markup-rows","-mesg","Type theme name:","-window-title","", "-eh","2"],
                 stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE)

default_themes_dir=os.path.expanduser("~/.config/wal-colorschemes")
user_themes_dir=os.path.expanduser("~/.config/wal/colorschemes/dark")

def parse_theme(theme:str,dir:str,message=""):
    colors = open(f'{dir}/{theme}.json', 'r')
    colors_data = json.load(colors)["colors"]
    color0 = colors_data[f"color{0}"]
    output = ""
    for i in range(8):
        background_color= colors_data[f"color{i}"]
        output += f"<span background='{background_color}' foreground='{color0}'> {i} </span>"
    return f"{message} {theme}\n{output}"

def write_to_rofi(input:str):
    rofi_process.stdin.write(str.encode(input+'\x0f'))

# rofi_list = user_themes
for theme in random_themes:
    write_to_rofi(f"<span>{theme}</span>")
for theme in user_themes:
    write_to_rofi(parse_theme(theme, user_themes_dir,"User:"))
for theme in dark_themes:
    write_to_rofi(parse_theme(theme, os.path.join(default_themes_dir,"dark"), "Dark:"))
for (i, theme) in enumerate( light_themes ):
    write_to_rofi(parse_theme(theme, os.path.join(default_themes_dir,"light"),"Light:"))
    light_themes[i]+=" -l"
rofi_select_index = int(bytes.decode(rofi_process.stdout.read()))
if rofi_select_index > 0:
    theme=(random_themes+user_themes+dark_themes+light_themes)[rofi_select_index]
    print(theme, end="")
else:
    print(open(os.path.expanduser("~/.cache/theme_name")).read())
# output = rofi_process.communicate()

