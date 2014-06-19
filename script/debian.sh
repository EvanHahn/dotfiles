#!/bin/bash

# let us install Hecka Stuff
# --------------------------

function aptget() {
	sudo apt-get install "${@}" -q=2
}

sudo apt-get update

aptget g++
aptget gcc
aptget lynx
aptget make
aptget ruby
aptget tmux
aptget vim
aptget xsel
aptget zsh

# common stuff
# ------------

source ./common/install_nvm.sh
source ./common/use_zsh.sh

# misc. Ubuntu
# ------------

rm $HOME/examples.desktop &> /dev/null
