#!/bin/bash

# let us install Hecka Stuff
# --------------------------

function aptget() {
	sudo apt-get install "${@}" -y
}

sudo apt-get update

aptget chromium-browser
aptget feh
aptget g++
aptget gcc
aptget gvim
aptget lynx
aptget make
aptget nodejs
aptget ruby
aptget tmux
aptget ttf-mscorefonts-installer
aptget vim
aptget vlc
aptget xcompmgr
aptget xfonts-terminus
aptget zsh

vim +BundleInstall +qall

# rap game zsh
# ------------

if [ ! $SHELL = '/bin/zsh' ]; then
	chsh -s $(which zsh)
	sudo chsh -s $(which zsh)
fi

# misc. Ubuntu
# ------------

rm $HOME/examples.desktop &> /dev/null

echo "feh --bg-fill PATH" > $HOME/.fehbg
