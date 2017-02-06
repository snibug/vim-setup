#!/usr/bin/python
import glob
import os
import subprocess

current_dir = os.path.abspath(os.path.dirname(__file__))
j = lambda *args: os.path.join(current_dir, *args)

jobs = [(j("vim"), "~/.vim"), (j("vimrc"), "~/.vimrc")]

for path, target in jobs:
    target = os.path.expanduser(target)
    if os.path.lexists(target):
        print target, "already exists"
    else:
        os.symlink(path, target)
        print "created", target


os.system('vim -c VundleUpdate -c quitall')

root_dir = os.path.dirname(os.path.abspath(__file__))
ycm_dir = os.path.join(root_dir, 'vim', 'bundle', 'YouCompleteMe')

install_command = [
    os.path.join(ycm_dir, 'install.py'),
    '--clang-completer',
    '--tern-completer',
    '--gocode-completer',
]
subprocess.Popen(install_command).wait()
