#!/sbin/python3


import os,subprocess, json

clients = json.loads(os.popen("hyprctl clients -j").read())
classes = [ client["class"] for client in clients ]
addresses = [ client["address"] for client in clients ]
titles = [ client["title"] for client in clients ]
print(classes, addresses, titles)

for i in reversed(range(len(classes))):
    if len( classes[i] ) < 1:
        classes.pop(i)
        addresses.pop(i)
        titles.pop(i)
    else:
        classes[i] += ", " + titles[i]

rofi_proccess = subprocess.Popen(["rofi","-dmenu","-format","i","-i"],stdin=subprocess.PIPE, stdout=subprocess.PIPE,stderr=subprocess.PIPE)

output = int(bytes.decode(rofi_proccess.communicate(input=str.encode("\n".join(classes)))[0]))

os.popen(f'hyprctl dispatch focuswindow "address:{addresses[output]}"')
