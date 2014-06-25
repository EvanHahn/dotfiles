#!/bin/bash

# let us install Hecka Stuff
# --------------------------

function aptget() {
	sudo apt-get install "${@}" -q=2
}

function pipget() {
	sudo pip install --upgrade "${@}" -q
}

sudo apt-get update -q=2

aptget build-essential
aptget g++
aptget gcc
aptget lynx
aptget make
aptget python-pip
aptget ruby
aptget tmux
aptget trash-cli
aptget unzip
aptget vim
aptget zsh

pipget pip
pipget virtualenv

# common stuff
# ------------

source ./common/install_nvm.sh
source ./common/npm.sh
source ./common/pip.sh
source ./common/use_zsh.sh

# misc. Ubuntu
# ------------

rm $HOME/examples.desktop &> /dev/null
