#!/bin/bash

# let us install Hecka Stuff
# --------------------------

function aptget() {
	sudo apt-get install "${@}" -y
}

aptget vim
aptget gvim
aptget lynx
aptget tmux
aptget zsh
aptget make
aptget gcc
aptget g++
aptget ruby
aptget nodejs
aptget ttf-mscorefonts-installer
aptget xfonts-terminus

vim +BundleInstall +qall

# rap game zsh
# ------------

if [ ! $SHELL = '/bin/zsh' ]; then
	chsh -s $(which zsh)
	sudo chsh -s $(which zsh)
fi
