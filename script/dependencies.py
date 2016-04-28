#!/usr/bin/env python

import os

dependencies = (
    ('resources/bin/el-rando', 'https://github.com/EvanHahn/el-rando.git'),
    ('resources/bin/is_github_up', 'https://github.com/EvanHahn/is-GitHub-up.git'),
    ('resources/bin/iscp', 'https://github.com/EvanHahn/iscp.git'),
    ('resources/bin/journ', 'https://github.com/EvanHahn/journ.git'),
    ('resources/bin/rename', 'https://github.com/EvanHahn/rename.git'),
)

my_path = os.path.dirname(os.path.realpath(__file__))
root_path = os.path.join(my_path, '..')

for (path, url) in dependencies:

    os.chdir(root_path)

    exists = os.path.isdir(path)
    if exists:
        print('Updating ' + path)
        os.chdir(path)
        os.system('git checkout master')
        os.system('git pull origin master')
    else:
        print('Grabbing ' + path)
        os.system('git clone {0} {1}'.format(url, path))

    print('')
