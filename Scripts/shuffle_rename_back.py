#!/bin/python

import os

namesFile=".names.txt"
shuffleFile=".shuffled.txt"
f = open(shuffleFile,"r")
if (not int(f.read())):
    print("Its normal. quitting.")
    exit()
f.close()

f = open(namesFile, "r")
for line in f.read().splitlines():
    # old name (shuffle) is names[1]
    # new name (original) names[0]
    names = line.split("%:%")
    os.rename(names[1],names[0])
    print(f"Renamed '{names[1]}' back to '{names[0]}'")

f = open(shuffleFile,"w")
f.write("0")
f.close()
