#!/bin/bash

if [ ! $SHELL = '$(which zsh)' ]; then
	chsh -s $(which zsh)
	sudo chsh -s $(which zsh)
fi
