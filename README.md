# dotfiles

This is a collection of many of my configuration files and scripts. I've been working on these since 2012 and am still learning a lot.

- `/home` contains [stow](https://www.gnu.org/software/stow/)able directories. After installing `stow`, `stow -t "$HOME" vim` should symlink `vim`. Feel free to stow anything of the other folders in there, like `tmux` or `zsh` or `lynx`.
- `/resources` contains miscellaneous resources that might require a little work. There's usually a README.

## Manual tasks

### Firefox

- [Decentraleyes](https://addons.mozilla.org/en-US/firefox/addon/decentraleyes/) (enabled in Private Windows)
- [uBlock Origin](https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/) (enabled in Private Windows)

- `privacy.resistFingerprinting: true`
- `mousewheel.with_meta.action: 0`

### macOS

- Switch to GNU versions
  1. `brew install coreutils grep gnu-sed gnu-tar gnu-which`
  1. Add `"$(brew --prefix coreutils)/libexec/gnubin"` to `$PATH` (replacing `coreutils` with `grep`, `gnu-sed`, etc)
  1. `alias ls='ls --color=auto'`
- Disable Spotlight suggestions
- `Defaults tty_tickets` with `sudo visudo`

### Debian

- `gnome-sushi`
- `ttf-mscorefonts-installer`
