from ranger.api.commands import *
import os
from collections import deque
from threading import Thread

class setwp(Command):
	def execute(self):
		self.fm.execute_console("shell /home/nima/Scripts/wal.sh "+str(self.fm.thisfile))
		self.fm.execute_console("shell /home/nima/Scripts/chcpio.sh")

class zip(Command):
    def __init__(self, *args, **kwargs):
        super(zip, self).__init__(*args, **kwargs)
        flags, _ = self.parse_flags()
        definedFlags = ["d", "m"]
        self._zip_directory = 'd' in flags
        self._stay_marked = 'm' in flags
        self._rest_flags = " ".join(["-"+flag for flag in flags if flag not in definedFlags])
    def execute(self):
        if (self._zip_directory):
            filenames = "./"
        else: 
            filenames = " ".join([f.relative_path for f in self.fm.thistab.get_selection()])
        self.fm.open_console("shell zip .zip " +filenames + " "+self._rest_flags,position=(10))
        if (not self._zip_directory and not self._stay_marked):
            self.fm.execute_console("unmark")
