#!/bin/bash

# Get platform
# ============

PLATFORM="unknown"
unamestr=`uname`
if [[ "$unamestr" == "Linux" ]]; then
	PLATFORM="Linux"
	if [ -f /etc/debian_version ] ; then
		PLATFORM="Ubuntu"
	fi
elif [[ "$unamestr" == "Darwin" ]]; then
	PLATFORM="OSX"
fi

# Do the symlinking
# =================

# Vim (.vimrc and .vim directory)
rm $HOME/.vimrc &> /dev/null
rm -r $HOME/.vim &> /dev/null
ln -s $PWD/../resources/vimrc $HOME/.vimrc &> /dev/null
ln -s $PWD/../resources/vim $HOME/.vim &> /dev/null

# Nano (.nanorc and .nano directory)
rm $HOME/.nanorc &> /dev/null
rm -r $HOME/.nano &> /dev/null
ln -s $PWD/../resources/nanorc $HOME/.nanorc &> /dev/null
ln -s $PWD/../resources/nano $HOME/.nano &> /dev/null

# SSH
rm $HOME/.ssh/config &> /dev/null
ln -s $PWD/../resources/sshconfig $HOME/.ssh/config &> /dev/null

# Git
rm $HOME/.gitconfig &> /dev/null
ln -s $PWD/../resources/gitconfig $HOME/.gitconfig &> /dev/null

# Input aliases
rm $HOME/.inputrc &> /dev/null
ln -s $PWD/../resources/inputrc $HOME/.inputrc &> /dev/null

# csh
rm $HOME/.cshrc &> /dev/null
ln -s $PWD/../resources/cshrc $HOME/.cshrc

# screen
rm $HOME/.screenrc &> /dev/null
ln -s $PWD/../resources/screenrc $HOME/.screenrc

# IRB
rm $HOME/.irbrc &> /dev/null
ln -s $PWD/../resources/irbrc $HOME/.irbrc

# basrc or bash_profile
# =====================

if [[ $PLATFORM == "OSX" ]]; then
	rm $HOME/.bash_profile &> /dev/null
	ln -s $PWD/../resources/bashrc $HOME/.bash_profile
else
	rm $HOME/.bashrc &> /dev/null
	ln -s $PWD/../resources/bashrc $HOME/.bashrc
fi
