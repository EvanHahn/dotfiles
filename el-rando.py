#!/usr/bin/env python
import random
from string import letters, digits, ascii_lowercase
import sys


punctuation = '!#$%&*+=@^'


def puts(val):
    sys.stdout.write(val)


def main(argv):

    command = 'string' if len(argv) < 2 else argv[1]

    if command in ('string', 'letters'):
        if command == 'string':
            chars = letters + digits + punctuation
        else:
            chars = ascii_lowercase
        count = 40 if len(argv) < 3 else int(argv[2])
        puts(''.join(random.choice(chars) for i in range(count)))

    elif command == 'bool':
        puts(('no', 'yes')[random.getrandbits(1)])

    elif command == 'number':
        if len(argv) == 2:
            lower_bound = 10000
            upper_bound = 99999
        elif len(argv) == 3:
            lower_bound = 0
            upper_bound = int(argv[2])
        else:
            lower_bound = int(argv[2])
            upper_bound = int(argv[3])
        puts(str(random.randint(lower_bound, upper_bound)))

    else:
        sys.stderr.write('cannot generate random ' + command + '\n')
        exit(1)


if __name__ == '__main__':
    main(sys.argv)
