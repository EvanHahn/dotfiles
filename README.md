my squiggle
===========

installation:

```sh
# clone this repo
script/symlink.sh

# if on OSX
script/osx-settings.sh
script/osx-packages.rb

script/dependencies.py
script/change-shell.sh
```

to update:

```sh
script/dependencies.py
vim +NeoBundleUpdate +qall
bru  # on OSX
```
