my squiggle
===========

installation:

```sh
# clone this repo

# if on OSX
script/osx-settings.sh

# if on Debian
sudo apt-get install ruby -y

script/packages.rb
script/dependencies.py
script/change-shell.sh
script/symlink.sh
```

to update:

```sh
script/dependencies.py
upup
```

manual steps on OS X:

- disable Spotlight suggestions
- `Defaults tty_tickets` with `visudo`
