#!/bin/python3

import sys
import subprocess

args=sys.argv[1:]
defined_options=["-s"]

# if its ssh, use ssh base url
if "-s" in args:
    base_url="git@github.com:"
    args.remove("-s")
else:
    base_url="https://github.com/"

repos=[]
options=[]

for arg in args:
    # if argument has 'something/somethingelse format'
    if len(arg.split('/')) > 1:
        repos.append(arg)
    elif arg not in defined_options:
        options.append(arg)

for repo in repos:
    subprocess.run(["git","clone",f"{base_url}{repo}.git"]+args)
