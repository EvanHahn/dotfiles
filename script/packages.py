#!/usr/bin/env python
from __future__ import print_function
import sys
import os


def eprint(*args, **kwargs):
        print(*args, file=sys.stderr, **kwargs)


current_dir = os.path.dirname(os.path.abspath(__file__))
packages_dir = os.path.join(current_dir, '..', 'resources', 'packages')

if len(sys.argv) < 2:
    packages_folders = os.listdir(packages_dir)

    eprint('usage: ./packages.py [PACKAGE LIST]')
    eprint()
    eprint('  try:')
    for f in os.listdir(packages_dir):
        if f[0] != '.':
            eprint('  ./packages.py ', f)
    exit(1)
