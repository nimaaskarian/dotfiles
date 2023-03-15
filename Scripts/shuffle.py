#!/bin/python

import random
import math
import os

namesFile=".names.txt"
shuffleFile=".shuffled.txt"
f = open(shuffleFile,"r")
if (int(f.read())):
    print("Its shuffled. quitting.")
    exit()
f.close()

os.rename(namesFile, namesFile+".backup")
music_list=[ file for file in os.listdir(".") if file.endswith("mp3") ]

numbers=[x for x in range(0,len(music_list))]
random.shuffle(numbers)

for i, music in enumerate(music_list):
    f = open(namesFile, "a")
    newName="{number:0{width}d}.mp3".format(width=math.ceil(math.log10(len(numbers))), number=numbers[i])
    f.write(f"{ music }%:%{ newName }\n")
    os.rename(music,newName)
    print(f"Renamed '{music}' to '{newName}'")
    f.close()

f = open(shuffleFile,"w")
f.write("1")
