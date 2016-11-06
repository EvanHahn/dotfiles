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

   if on Arch
   - install everything
   - `etckeeper init`
1. `script/packages.py [package manager]  # to install packages`
1. `script/dependencies.py  # because git submodules suck`
1. `chsh "$(which zsh)"  # to use ZSH`
1. `script/install-vim-plug.sh  # to install vim-plug`
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
