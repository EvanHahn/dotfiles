rename, an interactive mv
=========================

An interactive alternative to `mv`.

```sh
$ rename ron.txt
Rename ron.txt to: _
```

To use, simply pass one or more paths and `rename` will ask you, one by one, where to move it. It autofills the existing file name, which might be a bad assumption.

```sh
# Rename several files:
$ rename brian.gif champ.jpg

# Rename all files in a folder:
$ rename *

# Rename all C files:
$ rename *.c
```
