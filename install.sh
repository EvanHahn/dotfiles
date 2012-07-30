#!/bin/bash

# Ensure sudo power
# =================

sudo ls &> /dev/null

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

# "Gimme" function
# https://gist.github.com/2837693
# ===============================

function gimme {
	platform=""
	if [[ `uname` == "Linux" ]]; then
		platform="Linux"
		if [ -f /etc/debian_version ] ; then
			platform="Ubuntu"
		fi
	elif [[ `uname` == "Darwin" ]]; then
		platform="OSX"
	fi
	location=`which $1 | grep /`
	if [[ $location == "" ]]; then
		manager=$2
		flags=""
		if [[ $manager == "" ]]; then
			if [[ $platform == "Ubuntu" ]]; then
				manager="apt-get"
			elif [[ $platform == "OSX" ]]; then
				manager="port"
				if [[ `which port` == "" ]]; then
					curl https://distfiles.macports.org/MacPorts/MacPorts-2.1.1.tar.bz2 > MacPorts-2.1.1.tar.bz2
					tar xzvf MacPorts.tar.bz2
					cd MacPorts-2.1.1
					chmod +x configure
					./configure
					make
					sudo make install
					cd ../
					rm -rf MacPorts-2.1.1*
					sudo port selfupdate &> /dev/null
				fi
			fi
		fi
		if [[ $manager = "npm" ]]; then
			flags="-g"
		fi
		if [[ $manager == "" ]]; then
			echo "Unable to install $1 -- please specify platform or package manager"
		else
			package=$1
			if [[ $1 == "git" ]]; then
				package="git-core"
			elif [[ $1 == "node" ]]; then
				package="nodejs"
			elif [[ $1 == "mvim" ]]; then
				if [[ $platform == "OSX" ]]; then
					package="macvim"
				fi
			elif [[ $1 == "coffee" ]]; then
				package="coffee-script"
			elif [[ $1 == "lessc" ]]; then
				package="less"
			elif [[ $1 == "hg" ]]; then
				package="mercurial"
			elif [[ $1 == "ack" ]]; then
				if [[ $platform == "OSX" ]]; then
					package="p5-app-ack"
				elif [[ $platform == "Ubuntu" ]]; then
					package="ack-grep"
				fi
			fi
			command="install"
			if [[ $manager == "easy_install" ]]; then
				command=""
			fi
			echo "Installing $1"
			if [[ $flags == "" ]]; then
				sudo $manager $command $package
			else
				sudo $manager $command $flags $package
			fi
		fi
	else
		echo "$1 already installed"
	fi
}

# Common stuff
# ============

# Installs
gimme git
gimme lynx

# Shell RCs
rm $HOME/.cshrc &> /dev/null
ln -s $PWD/resources/cshrc $HOME/.cshrc
# bashrc is done differently depending on the platform.

# Ubuntu
# ======

if [[ $PLATFORM == "Ubuntu" ]]; then

	# Common stuff that's different on Ubuntu
	# --------------------------------------- 

	# TODO: gem?

	# Node + NPM
	if [[ `which npm` == "" ]]; then
		sudo apt-get install python-software-properties
		sudo apt-add-repository ppa:chris-lea/node.js
		sudo apt-get update
		sudo apt-get install nodejs npm
	fi

	# TODO: PIP

	# TODO: Inconsolata

	# bashrc
	rm $HOME/.bashrc &> /dev/null
	ln -s $PWD/resources/bashrc $HOME/.bashrc

	# Install stuff
	# -------------

	# Install updates
	sudo apt-get update
	sudo apt-get upgrade

	# Install restricted extras and stuff
	sudo apt-get install ubuntu-restricted-extras
	sudo apt-get install non-free-codecs libxine1-ffmpeg gxine mencoder totem-mozilla icedax tagtool easytag id3tool lame nautilus-script-audio-convert libmad0 mpg321 mpg123libjpeg-progs

	# VLC + Chromium
	sudo apt-get install vlc chromium-browser

	# TODO: Vim?
	# it seems like vim-tiny (rather than Vim) is installed by default.
	# https://help.ubuntu.com/community/VimHowto

	# Faenza icon theme
	sudo add-apt-repository ppa:tiheum/equinox
	sudo apt-get update
	sudo apt-get install faenza-icon-theme
	# TODO: Actually use this theme

	# TODO: dropbox
	# cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86" | tar xzf -

	# TODO: change default applicatoins
	# https://linuxowns.wordpress.com/2008/05/31/changing-default-applications/

# OS X
# ====

# Many of these are stolen from Mathias Bynens's .osx file.
# github.com/mathiasbynens/dotfiles/blob/master/.osx

elif [[ $PLATFORM == "OSX" ]]; then

	# Common stuff that's different on Mac
	# ------------------------------------

	# Package manager: MacPorts
	if [[ `which port` == "" ]]; then
		curl https://distfiles.macports.org/MacPorts/MacPorts-2.1.1.tar.bz2 > MacPorts-2.1.1.tar.bz2
		tar xzvf MacPorts.tar.bz2
		cd MacPorts-2.1.1
		chmod +x configure
		./configure
		make
		sudo make install
		cd ../
		rm -rf MacPorts-2.1.1*
	fi
	sudo port selfupdate &> /dev/null
	sudo port upgrade outdated &> /dev/null

	# Node + NPM
	gimme node

	# PIP
	if [[ `which pip` == "" ]]; then
		sudo easy_install pip
	fi

	# Inconsolata font
	cp $PWD/resources/Inconsolata.otf ~/Library/Fonts/

	# Installations
	# -------------

	# TODO: Cyberduck, AppCleaner, Firefox + Chrome

	# MacVim
	gimme mvim

	# Preferences 
	# -----------

	# TODO: preferences
	# see ~/Library/Preferences

	# TODO: email, address book

	# bashrc (well, not on OS X)
	rm $HOME/.bash_profile &> /dev/null
	ln -s $PWD/resources/bashrc $HOME/.bash_profile

	# TODO: default things to open with MacVim

	# TODO: FileVault

	# TODO: ignore when inserting things into the computer (see CDs and DVDs)

	# Finder
	# ------

	# Show extensions
	defaults write NSGlobalDomain AppleShowAllExtensions -bool true

	# Empty trash securely
	defaults write com.apple.finder EmptyTrashSecurely -bool true

	# Display full path in Finder windows 
	defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

	# No status bar in Finder
	defaults write com.apple.finder ShowStatusBar -bool false

	# Text in Quick Look is selectable
	defaults write com.apple.finder QLEnableTextSelection -bool true

	# Disable Finder animations
	defaults write com.apple.finder DisableAllAnimations -bool true

	# I will change file extensions whenever I got'damn please
	defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

	# I've never used AirDrop but it'll happen more now
	defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

	# Show ~/Library
	chflags nohidden ~/Library

	# Remove Dropbox's "I have synced" icons from Finder
	file=/Applications/Dropbox.app/Contents/Resources/check.icns
	[ -e "$file" ] && mv -f "$file" "$file.bak"
	unset file

	# Dock and stuff
	# --------------

	# Hide battery time and percentage
	defaults write com.apple.menuextra.battery ShowPercent -string "NO"
	defaults write com.apple.menuextra.battery ShowTime -string "NO"

	# Pin dock to left, make it the right size
	defaults write com.apple.dock pinning -string start
	defaults write com.apple.dock tilesize -int 32

	# Show indicator lights for open applications in the Dock
	defaults write com.apple.dock show-process-indicators -bool true

	# Stop .DS_Store on networks
	defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

	# Menu bar should be transparent
	defaults write NSGlobalDomain AppleEnableMenuBarTransparency -bool true

	# Disable dashboard
	defaults write com.apple.dashboard mcx-disabled -boolean YES

	# No Dock exposé
	defaults write com.apple.dock show-expose-menus -boolean no

	# Keyboard and mouse stuff
	# ------------------------

	# No press-and-hold stuff, nor autocorrect
	defaults write -g ApplePressAndHoldEnabled -bool false
	defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

	# HOW FAST YOU WANT THOSE KEYS TO REPEAT???
	defaults write NSGlobalDomain KeyRepeat -int 0

	# Trackpad tap to click
	defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
	defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
	defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

	# Scroll more better
	defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

	# Enable keyboard access everywhere
	defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

	# Misc.
	# -----

	# Expand save and print panels by default
	defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
	defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

	# Disable "hey um did you not wanna open this, it's from Internet"
	defaults write com.apple.LaunchServices LSQuarantine -bool false

	# Destroy Ping in iTunes
	defaults write com.apple.iTunes disablePingSidebar -bool true
	defaults write com.apple.iTunes disablePing -bool true

	# Graphite, not Aqua
	defaults write NSGlobalDomain AppleAquaColorVariant -int 6

	# Speed up dialog boxes
	defaults write NSGlobalDomain NSWindowResizeTime 0.1

	# Lower screensharing image quality to 16-bit
	defaults write com.apple.ScreenSharing controlObserveQuality 4

	# Screenshots should be PNG "Screenshot" not "Screen Shot", and on Desktop
	defaults write com.apple.screencapture name "Screenshot"
	defaults write com.apple.screencapture location -string "$HOME/Desktop"
	defaults write com.apple.screencapture type -string "png"

	# All done!
	# ---------

	killall Finder
	killall Dock
	killall SystemUIServer

fi

# More common stuff
# =================

# Make a ~/Coding directory
mkdir $HOME/Coding &> /dev/null

# Make an alias to ~/Dropbox/Notes (just as ~/Notes)
if [ -d $HOME/Dropbox/Notes ] ; then
	ln -s $HOME/Dropbox/Notes $HOME/Notes &> /dev/null
fi

# Vim aliases (.vimrc and .vim directory)
rm $HOME/.vimrc &> /dev/null
rm -r $HOME/.vim &> /dev/null
ln -s $PWD/resources/vimrc $HOME/.vimrc &> /dev/null
ln -s $PWD/resources/vim $HOME/.vim &> /dev/null

# Nano aliases (.nanorc and .nano directory)
rm $HOME/.nanorc &> /dev/null
rm -r $HOME/.nano &> /dev/null
ln -s $PWD/resources/nanorc $HOME/.nanorc &> /dev/null
ln -s $PWD/resources/nano $HOME/.nano &> /dev/null

# SSH aliases
rm $HOME/.ssh/config &> /dev/null
ln -s $PWD/resources/sshconfig $HOME/.ssh/config &> /dev/null

# Git aliases
rm $HOME/.gitconfig &> /dev/null
ln -s $PWD/resources/gitconfig $HOME/.gitconfig &> /dev/null

# Input aliases
rm $HOME/.inputrc &> /dev/null
ln -s $PWD/resources/inputrc $HOME/.inputrc &> /dev/null

# Legit (git-legit.org)
if [[ `which legit` == "" ]]; then
	sudo pip install legit
	legit install
fi

# CoffeeScript and LESS and Stylus
gimme coffee npm
gimme lessc npm
gimme stylus npm

# Pianobar (for Pandora)
gimme pianobar

# Ack, a grep alternative
gimme ack

# YEEAH DONE!
# ===========

echo "All done!"
