#!/usr/bin/env bash
set -e
set -u
set -o pipefail

curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
curl -fLo "$XDG_CONFIG_HOME/nvim/autoload/plug.vim" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
