#!/usr/bin/env python

import os

dependencies = (
    ('bins/journ', 'https://github.com/EvanHahn/journ.git'),
    ('bins/iscp', 'https://github.com/EvanHahn/iscp.git'),
    ('bins/rename', 'https://github.com/EvanHahn/rename.git'),
    ('bins/is_github_up', 'https://github.com/EvanHahn/is-GitHub-up.git'),
    ('bins/el-rando', 'https://github.com/EvanHahn/el-rando.git'),
)

my_path = os.path.dirname(os.path.realpath(__file__))
root_path = os.path.join(my_path, '..')
os.chdir(root_path)

for (path, url) in dependencies:
    exists = os.path.isdir(path)
    subtree_command = 'pull' if exists else 'add'

    os.system('git subtree {0} --prefix {1} {2} master --squash'.format(
        subtree_command, path, url))
