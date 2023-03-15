#!/bin/python3
import sys, subprocess, os

args = sys.argv[1:]

if os.path.exists(args[0]):
    md5s = []
    dups = []

    for file in os.listdir(args[0]):
        if not os.path.isfile(file): continue

        current_md5 = subprocess.run(["md5sum",file],stdout=subprocess.PIPE).stdout.decode('utf-8').split(' ')[0]
        if current_md5 in md5s:
            dups.append(file)
        else:
            md5s.append(current_md5)

    # for dup in dups: os.remove(dup)
    print(dups)
