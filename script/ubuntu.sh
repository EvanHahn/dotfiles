#!/bin/bash

# let us install Hecka Stuff
# --------------------------

function aptget() {
	sudo apt-get install "${@}" -y
}

aptget lynx
aptget tmux
aptget zsh
aptget make
aptget gcc
aptget g++
aptget ruby
aptget nodejs

# rap game zsh
# ------------

if [ ! $SHELL = '/bin/zsh' ]; then
	chsh -s /bin/zsh
	sudo chsh -s /bin/zsh
fi
