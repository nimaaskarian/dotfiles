#!/bin/python3

import sys
import os
import mutagen
from mutagen.mp3 import MP3

class FString:
    def __init__(self, str, vars,values):
        words = [word for word in str.split()]
        for index, var in enumerate(vars):
            varIndex = -1
            try:
                varIndex = words.index("{" + var + "}")
            except ValueError:
                pass
            if varIndex == -1: continue
            words[varIndex] = values[index]
        self.words = words
    def __str__(self) -> str:
        return " ".join(self.words)

args = sys.argv[1:]
inputString = False
for arg in args: 
    if (arg.startswith("-f")):
        inputString = arg.split("=")[1]
        break

if not inputString:
    inputString = input("format: ")
for arg in args:
    if not os.path.isfile(arg): continue
    if type(mutagen.File(arg)) != MP3: continue
    mp3Object = MP3(arg)
    artist = "".join(mp3Object.tags['TPE2'].text)
    name = "".join(mp3Object.tags['TIT2'].text)
    print(FString(inputString, ["name","artist"],[name,artist]))
