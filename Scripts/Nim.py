#!/bin/python3

import subprocess
import sys

def init():
    args = sys.argv
    try:
        print(readFile(args[1]))    
    except:
        subprocess.run(["touch", args[1]])
    lines =""
    while True:
        try:
            line = input()
        except EOFError:
            writeFile(args[1],lines) 
            break
        lines = line +"\n"

def readFile(path): return open(path,"r").read()
def writeFile(path,content): return open(path,"a").write(content)
init()
