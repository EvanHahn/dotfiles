# Evan Hahn's dotfiles

My configuration files for (neo)vim, tmux, zsh, and so on.

Used on Debian-likes and macOS. Might work elsewhere.

I've been working on these dotfiles since 2012 and am still learning a lot. I wrote [a blog post with some reflections](https://evanhahn.com/a-decade-of-dotfiles/). [Contact me](https://evanhahn.com/contact/) with any questions.

## Setup

General setup:

1. install `stow`
1. `cd home`
1. stow whatever you want. For example, `stow -t "$HOME" tmux vim` grabs tmux and vim config

On macOS, switch to the GNU versions:

1. `brew install coreutils grep gnu-sed gnu-tar gnu-which`
1. Add `"$(brew --prefix coreutils)/libexec/gnubin"` to `$PATH` (replacing `coreutils` with `grep`, `gnu-sed`, etc)
1. `alias ls='ls --color=auto'`

Set up Vim thesaurus:

1. Download a MyThes thesaurus file (grab the `.dat` file from [this ZIP](https://lingucomponent.openoffice.org/MyThes-1.zip))
1. `scripts/parse-thesaurus /path/to/th_en_US_new.dat > ~/.cache/evanhahn-vim-thesaurus`
