#!/usr/bin/env bash
set -e
set -u
set -o pipefail

XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}

curl 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' \
  --fail \
  --location \
  --output "$XDG_CONFIG_HOME/nvim/autoload/plug.vim" \
  --create-dirs
