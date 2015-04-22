journ
=====

I store my journal in a single folder like this:

```
📁 journal
    📝 2014-04-18.txt
    📝 2014-04-19.txt
    📝 2014-04-20.txt
    📝 2014-04-21.txt
    📝 ...
```

If you do too, `journ` is for you.

Setup
-----

1. Put the `journ` executable somewhere in your $PATH.
2. Set the `$JOURN_PATH` environment variable (probably in your bashrc). This should be the path of a folder where all of your journal files will live.

Usage
-----

```sh
# Edit today's file
journ

# Edit yesterday's file
journ -y

# Edit today's file in another editor
EDITOR=atom journ

# Print the path to today's file
journ -f

# Print $JOURN_PATH
journ -p

# Print the number of entries
journ -c
```

That's it!
