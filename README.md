my squiggle ~
=============

these are my dotfiles

i haven't really organized them for other people, but if you have questions, feel free to email me at <me@evanhahn.com>

installation
------------

1. clone this repo
1. if on OS X
   - install [Homebrew](http://brew.sh/)
   - `script/osx-settings.sh`
   - disable Spotlight suggestions
   - `Defaults tty_tickets` with `visudo`
1. `script/packages.rb  # to install packages`
1. `script/dependencies.py  # because git submodules suck`
1. `script/change-shell.sh  # to use ZSH`
1. `cd home && stow -t "$HOME" *  # to symlink all files`

update
------

```sh
script/dependencies.py
upup
```

firefox extensions
------------------

- dotjs
- Ghostery
- HTTPS Everywhere
- NoScript
- Tree Style Tab
- Vimperator