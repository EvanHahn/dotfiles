#!/bin/bash

# Bash
rm $HOME/.bash_profile &> /dev/null
ln -s $PWD/../resources/bashrc $HOME/.bash_profile
rm $HOME/.bashrc &> /dev/null
ln -s $PWD/../resources/bashrc $HOME/.bashrc
rm -r $HOME/.bash &> /dev/null
ln -s $PWD/../resources/bash $HOME/.bash &> /dev/null

# csh
rm $HOME/.cshrc &> /dev/null
ln -s $PWD/../resources/cshrc $HOME/.cshrc

# EditorConfig
rm $HOME/.editorconfig &> /dev/null
ln -s $PWD/../resources/editorconfig $HOME/.editorconfig &> /dev/null

# Finch
rm $HOME/.gntrc &> /dev/null
ln -s $PWD/../resources/gntrc $HOME/.gntrc

# Git
rm $HOME/.gitconfig &> /dev/null
ln -s $PWD/../resources/gitconfig $HOME/.gitconfig &> /dev/null
rm $HOME/.gitignore_global &> /dev/null
ln -s $PWD/../resources/gitignore_global $HOME/.gitignore_global &> /dev/null

# Input
rm $HOME/.inputrc &> /dev/null
ln -s $PWD/../resources/inputrc $HOME/.inputrc &> /dev/null

# IRB
rm $HOME/.irbrc &> /dev/null
ln -s $PWD/../resources/irbrc $HOME/.irbrc

# less history, begone
rm $HOME/.lesshst &> /dev/null
ln -s /dev/null $HOME/.lesshst

# screen
rm $HOME/.screenrc &> /dev/null
ln -s $PWD/../resources/screenrc $HOME/.screenrc

# SSH
rm $HOME/.ssh/config &> /dev/null
ln -s $PWD/../resources/sshconfig $HOME/.ssh/config &> /dev/null

# Sublime
if [[ `uname` == "Darwin" ]]; then
	rm $HOME/Library/Application\ Support/Sublime\ Text\ 2/Packages/User/Preferences.sublime-settings
	ln -s $PWD/../resources/Preferences.sublime-settings $HOME/Library/Application\ Support/Sublime\ Text\ 2/Packages/User/Preferences.sublime-settings
fi

# tmux
rm $HOME/.tmux.conf &> /dev/null
ln -s $PWD/../resources/tmuxconf $HOME/.tmux.conf
rm $HOME/.tmux-osx.conf &> /dev/null
ln -s $PWD/../resources/tmuxconf-osx $HOME/.tmux-osx.conf

# Vim (.vimrc and .vim directory)
rm $HOME/.vimrc &> /dev/null
rm -r $HOME/.vim &> /dev/null
ln -s $PWD/../resources/vimrc $HOME/.vimrc &> /dev/null
ln -s $PWD/../resources/vim $HOME/.vim &> /dev/null

# Vimperator
rm $HOME/.vimperatorrc &> /dev/null
ln -s $PWD/../resources/vimperatorrc $HOME/.vimperatorrc &> /dev/null

# zsh
rm $HOME/.zshrc &> /dev/null
ln -s $PWD/../resources/zshrc $HOME/.zshrc &> /dev/null
rm -r $HOME/.zsh &> /dev/null
ln -s $PWD/../resources/zsh $HOME/.zsh &> /dev/null

# JSHint
rm $HOME/.jshintrc &> /dev/null
ln -s $PWD/../resources/jshintrc $HOME/.jshintrc &> /dev/null

# xmonad, Xresources, xinit
rm $HOME/.xinitrc &> /dev/null
rm $HOME/.xsession &> /dev/null
ln -s $PWD/../resources/xsession $HOME/.xsession &> /dev/null
ln -s $PWD/../resources/xsession $HOME/.xinitrc &> /dev/null
rm -r $HOME/.xmonad &> /dev/null
ln -s $PWD/../resources/xmonad $HOME/.xmonad &> /dev/null
rm $HOME/.Xresources &> /dev/null
ln -s $PWD/../resources/Xresources $HOME/.Xresources &> /dev/null

# Atom
rm -r $HOME/.atom &> /dev/null
ln -s $PWD/../resources/atom $HOME/.atom &> /dev/null
