#!/usr/bin/env bash
set -e
set -u
set -o pipefail

XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}

curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
curl -fLo "$XDG_CONFIG_HOME/nvim/autoload/plug.vim" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
