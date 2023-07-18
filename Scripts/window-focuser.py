#!/sbin/python3


import os,subprocess

classes = os.popen("hyprctl clients -j | jq '.[] | .class'").read().replace('"','').splitlines()
addresses = os.popen("hyprctl clients -j | jq '.[] | .address'").read().replace('"','').splitlines()
titles = os.popen("hyprctl clients -j | jq '.[] | .title'").read().replace('"','').splitlines()

for i in reversed(range(len(classes))):
    if len( classes[i] ) < 1:
        classes.pop(i)
        addresses.pop(i)
        titles.pop(i)
    else:
        classes[i] += ", " + titles[i]

rofi_proccess = subprocess.Popen(["rofi","-dmenu","-format","i","-i"],stdin=subprocess.PIPE, stdout=subprocess.PIPE,stderr=subprocess.PIPE)

output = int(bytes.decode(rofi_proccess.communicate(input=str.encode("\n".join(classes)))[0]))
print(addresses[output])
