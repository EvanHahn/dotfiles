#!/bin/bash
set -e

# let us install Hecka Stuff
# --------------------------

function aptget() {
	sudo apt-get install "${@}" -q=2
}

function pipget() {
	sudo pip install --upgrade "${@}" -q
}

aptget software-properties-common
sudo add-apt-repository ppa:kilian/f.lux -y

sudo apt-get update -q=2

aptget build-essential
aptget chromium-browser
aptget curl
aptget g++
aptget gcc
aptget gdm
aptget lynx
aptget make
aptget pepperflashplugin-nonfree
aptget python-pip
aptget ruby
aptget tmux
aptget trash-cli
aptget ubuntu-restricted-extras
aptget unzip
aptget vim
aptget xclip
aptget xfce4
aptget zsh

aptget firefox
aptget fluxgui
aptget gedit
aptget vlc
aptget steam

# fonts
# -----

mkdir -p $HOME/.fonts

cd /tmp

if [ ! -e "$HOME/.fonts/SourceCodePro-*.otf" ]; then
  wget http://downloads.sourceforge.net/project/sourcecodepro.adobe/SourceCodePro_FontsOnly-1.017.zip -O SourceCodePro.zip
  unzip SourceCodePro.zip
  mv SourceCodePro/OTF/*.otf $HOME/.fonts
fi

if [ ! -e "$HOME/.fonts/OpenSans-*.ttf" ]; then
  wget http://www.fontsquirrel.com/fonts/download/open-sans -O OpenSans.zip
  unzip OpenSans.zip -d OpenSans
  mv OpenSans/*.ttf $HOME/.fonts
fi

cd -

fc-cache -f

# common stuff
# ------------

source ./common/install_nvm.sh
source ./common/npm.sh
source ./common/pip.sh
source ./common/use_zsh.sh

# misc. Ubuntu
# ------------

rm $HOME/examples.desktop &> /dev/null
