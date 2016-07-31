# ===============================================
# Ranger Command Extensions (WIP)
# ===============================================
#
# Since deleting things with `rm` on a system
# with a trash is a bit of a waste, I've written
# two commands to make use of OSX's trash. The
# interface to this is based on Ali Rantakari's
# excellent 'trash' program.
#
# The other planned extension is a rewrite of the
# default `:terminal` command to open a native
# Terminal window, instead of opening fucking X
# every time you want to do something in bash.
#
# ===============================================
# from https://github.com/atheriel/ranger-config
#
from ranger.api.commands import *

# class terminal(Command):
#     """:terminal

#     Spawns an "x-terminal-emulator" starting in the current directory.
#     """
#     def execute(self):
#         import os
#         from ranger.ext.get_executables import get_executables
#         command = os.environ.get('TERMCMD', os.environ.get('TERM'))
#         if command not in get_executables():
#             command = 'x-terminal-emulator'
#         if command not in get_executables():
#             command = 'xterm'
#         self.fm.run(command, flags='f')


class trash(Command):
    """:trash [-q]
    Moves the selected files to the trash bin using Ali Rantakari's 'trash'
    program. Optionally takes the -q flag to suppress listing the files
    afterwards.
    """

    def execute(self):

        # Calls the trash program
        action = ['trash']
        action.extend(f.path for f in self.fm.thistab.get_selection())
        self.fm.execute_command(action)

        # TODO: check if the trashing was successful.

        # Echoes the basenames of the trashed files
        if not self.rest(1) == "-q":
            names = []
            names.extend(f.basename for f in self.fm.thistab.get_selection())
            self.fm.notify("Files moved to the trash: " + ', '.join(map(str, names)))


class empty_trash(Command):
    """:empty_trash [-s] [secure]
    Empties the trash bin using Ali Rantakari's 'trash' program. Add the
    optional -s flag for emptying securely, or the string 'secure'.
    """

    def execute(self):

        # Calls the trash program
        action = ['trash']
        if self.rest(1) == "-s" or self.rest(1) == "secure":
            action.extend(['-es'])
        else:
            action.extend(['-e'])
        self.fm.execute_command(action)