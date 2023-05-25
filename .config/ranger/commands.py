from ranger.api.commands import *
import os
from collections import deque
from threading import Thread

class setwp(Command):
	def execute(self):
		self.fm.execute_console("shell /home/nima/Scripts/wal.sh "+str(self.fm.thisfile))
		# self.fm.execute_console("shell /home/nima/Scripts/chcpio.sh")

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
class yank(Command):
    """:yank [name|dir|path]

    Copies the file's name (default), directory or path into both the primary X
    selection and the clipboard.
    """

    modes = {
        '': 'basename',
        'name_without_extension': 'basename_without_extension',
        'name': 'basename',
        'dir': 'dirname',
        'path': 'path',
    }

    def execute(self):
        import subprocess

        def clipboards():
            from ranger.ext.get_executables import get_executables
            clipboard_managers = {
                'xclip': [
                    ['xclip'],
                    ['xclip', '-selection', 'clipboard'],
                ],
                'xsel': [
                    ['xsel'],
                    ['xsel', '-b'],
                ],
                'wl-copy': [
                    ['wl-copy'],
                ],
                'pbcopy': [
                    ['pbcopy'],
                ],
            }
            ordered_managers = ['wl-copy', 'xclip', 'xsel']
            executables = get_executables()
            for manager in ordered_managers:
                if manager in executables:
                    return clipboard_managers[manager]
            return []

        clipboard_commands = clipboards()

        mode = self.modes[self.arg(1)]
        selection = self.get_selection_attr(mode)

        new_clipboard_contents = "\n".join(selection)
        for command in clipboard_commands:
            process = subprocess.Popen(command, universal_newlines=True,
                                       stdin=subprocess.PIPE)
            process.communicate(input=new_clipboard_contents)

    def get_selection_attr(self, attr):
        return [getattr(item, attr) for item in
                self.fm.thistab.get_selection()]

    def tab(self, tabnum):
        return (
            self.start(1) + mode for mode
            in sorted(self.modes.keys())
            if mode
        )
