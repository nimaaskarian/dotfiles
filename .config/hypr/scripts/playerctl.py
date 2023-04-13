#!/bin/python3
import subprocess
import sys
import re
import os

args=sys.argv[1:]
def init():
    players = run(["playerctl", "-l", "-s"]).splitlines()

    player_file="/tmp/player"
    current_player = ""
    if os.path.exists(player_file):
        f = open(player_file, "r")
        current_player = f.read()

    if len(players) == 1 and players[0] == current_player:
        return

    uniqPlayers = []
    metas = []
    for p in players: 
        current_meta = meta(p)
        if current_meta not in metas or (re.sub("\..*$",'',p) not in uniqPlayers and re.sub("\..*$",'',p) != current_player):
            metas.append(current_meta)
            uniqPlayers.append(p)

    print("\n".join([p for p in uniqPlayers if (p != current_player) or "-c" in args ]))

def run(cmdArray):
    return subprocess.run(cmdArray, stdout=subprocess.PIPE, stderr=subprocess.DEVNULL).stdout.decode('utf-8')
def meta(player):
    default_array = ["playerctl", "-p", player, "metadata"]

    if run(default_array + ["artist"]):
        return run(default_array + ["--format" ,'{{artist}} - {{markup_escape(title)}}'])

    return run(default_array + ["--format" ,'{{markup_escape(title)}}'])

init()
