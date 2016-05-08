#!/usr/bin/env python
from __future__ import print_function
import sys
import os
import subprocess


def eprint(*args, **kwargs):
        print(*args, file=sys.stderr, **kwargs)


def get_package_managers():
    for f in os.listdir(packages_dir):
        if f[0] != '.':
            yield f


current_dir = os.path.dirname(os.path.abspath(__file__))
packages_dir = os.path.join(current_dir, '..', 'resources', 'packages')
devnull = open('/dev/null', 'w')

if len(sys.argv) < 2:
    packages_folders = os.listdir(packages_dir)

    eprint('usage: ./packages.py [PACKAGE LIST]')
    eprint()
    eprint('  try:')
    for m in get_package_managers():
        eprint('  ./packages.py ', m)
    exit(1)

package_manager = sys.argv[1]

package_dir = os.path.join(packages_dir, package_manager)

if not os.path.isdir(package_dir):
    eprint(package_manager, 'is not a valid package manager')
    eprint()
    eprint('valid package managers:')
    for m in get_package_managers():
        eprint('*', m)
    exit(1)

check_installed_bin = os.path.join(package_dir, 'check_installed')
if subprocess.call([check_installed_bin], stdout=devnull, stderr=devnull) != 0:
    eprint(package_manager, 'does not appear to be installed')
    exit(1)
