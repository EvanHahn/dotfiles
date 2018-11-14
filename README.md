~ dotfiles
==========

These are many of my configuration files and scripts. Email <me@evanhahn.com> if you have questions, I'm happy to help!

The basics
----------

`/home` contains [stow](https://www.gnu.org/software/stow/)able directories. After installing `stow`, `stow -t "$HOME" vim` should symlink `vim`.

`/resources` contains miscellaneous resources that might require a little work. There's usually a README.

Manual tasks
------------

I always paw through all the settings when setting up a new machine, so you should too!

### macOS

- disable Spotlight suggestions
- `Defaults tty_tickets` with `sudo visudo`

Suggested software
------------------

I haven't listed things I won't forget (like Firefox or Git).

- Firefox extensions
  - HTTPS Everywhere
  - Decentraleyes

- `shellcheck`

- Ubuntu
  - `fonts-inconsolata`
  - `fonts-lato`
  - `ttf-mscorefonts-installer`
