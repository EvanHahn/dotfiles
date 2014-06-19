#!/bin/bash

# let us install Hecka Stuff
# --------------------------

function aptget() {
	sudo apt-get install "${@}" -y
}

sudo apt-get update

aptget g++
aptget gcc
aptget lynx
aptget make
aptget ruby
aptget tmux
aptget vim
aptget zsh

# rap game zsh
# ------------

if [ ! $SHELL = '$(which zsh)' ]; then
	chsh -s $(which zsh)
	sudo chsh -s $(which zsh)
fi

# misc. Ubuntu
# ------------

rm $HOME/examples.desktop &> /dev/null
