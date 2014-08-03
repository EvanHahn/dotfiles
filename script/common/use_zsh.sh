#!/bin/bash
set -e

if [ ! $SHELL = '$(which zsh)' ]; then
	chsh -s $(which zsh)
	sudo chsh -s $(which zsh)
fi
