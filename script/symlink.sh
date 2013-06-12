#!/bin/bash

# Vim (.vimrc and .vim directory)
rm $HOME/.vimrc &> /dev/null
rm -r $HOME/.vim &> /dev/null
ln -s $PWD/../resources/vimrc $HOME/.vimrc &> /dev/null
ln -s $PWD/../resources/vim $HOME/.vim &> /dev/null

# Vimperator
rm $HOME/.vimperatorrc &> /dev/null
ln -s $PWD/../resources/vimperatorrc $HOME/.vimperatorrc &> /dev/null

# Sublime symlinking
if [[ `uname` == "Darwin" ]]; then
	rm $HOME/Library/Application\ Support/Sublime\ Text\ 2/Packages/User/Preferences.sublime-settings
	ln -s $PWD/../resources/Preferences.sublime-settings $HOME/Library/Application\ Support/Sublime\ Text\ 2/Packages/User/Preferences.sublime-settings
fi

# Chrome
if [[ `uname` == "Darwin" ]]; then
	cat $PWD/../resources/chrome-custom.css > $HOME/Library/Application\ Support/Google/Chrome/Default/User\ StyleSheets/Custom.css
fi

# SSH
rm $HOME/.ssh/config &> /dev/null
ln -s $PWD/../resources/sshconfig $HOME/.ssh/config &> /dev/null

# Git
rm $HOME/.gitconfig &> /dev/null
ln -s $PWD/../resources/gitconfig $HOME/.gitconfig &> /dev/null
rm $HOME/.gitignore_global &> /dev/null
ln -s $PWD/../resources/gitignore_global $HOME/.gitignore_global &> /dev/null

# Input aliases
rm $HOME/.inputrc &> /dev/null
ln -s $PWD/../resources/inputrc $HOME/.inputrc &> /dev/null

# tmux
rm $HOME/.tmux.conf &> /dev/null
ln -s $PWD/../resources/tmuxconf $HOME/.tmux.conf

# screen
rm $HOME/.screenrc &> /dev/null
ln -s $PWD/../resources/screenrc $HOME/.screenrc

# IRB
rm $HOME/.irbrc &> /dev/null
ln -s $PWD/../resources/irbrc $HOME/.irbrc

# basrc and bash_profile
rm $HOME/.bash_profile &> /dev/null
ln -s $PWD/../resources/bashrc $HOME/.bash_profile
rm $HOME/.bashrc &> /dev/null
ln -s $PWD/../resources/bashrc $HOME/.bashrc

# csh
rm $HOME/.cshrc &> /dev/null
ln -s $PWD/../resources/cshrc $HOME/.cshrc

# zsh
rm $HOME/.zshrc &> /dev/null
ln -s $PWD/../resources/zshrc $HOME/.zshrc &> /dev/null
rm -r $HOME/.zsh &> /dev/null
ln -s $PWD/../resources/zsh $HOME/.zsh &> /dev/null
