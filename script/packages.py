#!/usr/bin/env python
from __future__ import print_function
import sys
import os
import subprocess


current_dir = os.path.dirname(os.path.abspath(__file__))
packages_dir = os.path.join(current_dir, '..', 'resources', 'packages')
devnull = open('/dev/null', 'w')


def eprint(*args, **kwargs):
        print(*args, file=sys.stderr, **kwargs)


def gets(prompt):
    if sys.version_info[0] < 3:
        return raw_input(prompt)
    else:
        return input(prompt)


def get_package_managers():
    for f in os.listdir(packages_dir):
        if f[0] != '.':
            yield f


def not_enough_arguments():
    eprint('usage: ./packages.py [PACKAGE LIST]')
    eprint()
    eprint('  try:')
    for m in get_package_managers():
        eprint('  ./packages.py ', m)
    exit(1)


def invalid_package_manager(package_manager):
    eprint(package_manager, 'is not a valid package manager')
    eprint()
    eprint('valid package managers:')
    for m in get_package_managers():
        eprint('*', m)
    exit(1)


def package_dir(package_manager):
    return os.path.join(packages_dir, package_manager)


def file_path(package_manager, f):
    return os.path.join(package_dir(package_manager), f)


def check_package_manager_installed(package_manager):
    check_installed_bin = os.path.join(package_dir(package_manager),
                                       'check_installed')
    check_installed_result = subprocess.call([check_installed_bin],
                                             stdout=devnull, stderr=devnull)
    if check_installed_result != 0:
        eprint(package_manager, 'does not appear to be installed')
        exit(1)


def first_word(s):
    return s.split()[0]


def packages_to_ask_about(package_manager):
    desired_txt = file_path(package_manager, 'desired')
    existing_bin = file_path(package_manager, 'existing')

    existing = set(subprocess.check_output([existing_bin]).split('\n'))

    for desired in open(desired_txt):
        desired = desired.strip()
        if len(desired) == 0:
            continue
        desired_name = first_word(desired)
        if desired_name not in existing:
            yield desired


def main(argv):
    if len(argv) < 2:
        not_enough_arguments()

    package_manager = argv[1]

    if not os.path.isdir(package_dir(package_manager)):
        invalid_package_manager(package_manager)

    check_package_manager_installed(package_manager)

    packages_to_install = []
    for package in packages_to_ask_about(package_manager):
        user_says = gets('install ' + first_word(package) + ' (Y/n)? ').strip()
        if user_says.lower() in ['', 'y', 'yes', 'yas']:
            packages_to_install.append(package)

    print()

    if len(packages_to_install) == 0:
        print("i guess we're done here")
        return

    print("alright, let's do this")
    print()

    preamble_bin = file_path(package_manager, 'preamble')
    if os.path.isfile(preamble_bin):
        subprocess.call(file_path(package_manager, 'preamble'), shell=True)

    install_command_bin = file_path(package_manager, 'install_command')
    for package in packages_to_install:
        cmd = subprocess.check_output([install_command_bin, package]).strip()
        subprocess.call(cmd, shell=True)


if __name__ == '__main__':
    main(sys.argv)
