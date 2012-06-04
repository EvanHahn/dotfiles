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
					sudo port -v selfupdate
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
			fi
			if [[ $flags == "" ]]; then
				sudo $manager install $package
			else
				sudo $manager install $flags $package
			fi
		fi
	else
		echo "$1 already installed"
	fi
}

# Common stuff
# ============

gimme git
gimme lynx

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

	# TODO: color ls command (done by default?)
	# ls --color=auto

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

# OS X
# ====

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
		sudo port -v selfupdate
	fi

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

	# Mac App Store stuff? TODO

	# Preferences 
	# -----------

	# TODO: preferences
	# see ~/Library/Preferences

	# TODO: email, address book

	# bashrc (well, not on OS X)
	rm $HOME/.bash_profile 2> /tmp/log.txt
	ln -s $PWD/resources/mac/bash_profile $HOME/.bash_profile

	# TODO: default things to open with MacVim

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

	# Misc.
	# -----

	# No press-and-hold stuff, nor autocorrect
	defaults write -g ApplePressAndHoldEnabled -bool false
	defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

	# HOW FAST YOU WANT THOSE KEYS TO REPEAT???
	defaults write NSGlobalDomain KeyRepeat -int 0

	# Trackpad tap to click
	defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
	defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
	defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

	# Expand save and print panels by default
	defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
	defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

	# Disable "hey did you wanna open this it's from Internet"
	defaults write com.apple.LaunchServices LSQuarantine -bool false

	# Destroy Ping in iTunes
	defaults write com.apple.iTunes disablePingSidebar -bool true
	defaults write com.apple.iTunes disablePing -bool true

	# All done!
	# ---------

	killall Finder
	killall Dock

fi

# More common stuff
# =================

# Make a ~/Coding directory
mkdir $HOME/Coding 2> /tmp/log.txt

# Vim aliases (vimrc and vim directory)
rm $HOME/.vimrc 2> /tmp/log.txt
rm -r $HOME/.vim 2> /tmp/log.txt
ln -s $PWD/resources/vimrc $HOME/.vimrc 2> /tmp/log.txt
ln -s $PWD/resources/vim $HOME/.vim 2> /tmp/log.txt

# SSH aliases
rm $HOME/.ssh/config 2> /tmp/log.txt
ln -s $PWD/resources/sshconfig $HOME/.ssh/config 2> /tmp/log.txt

# Git settings
git config --global user.name "Evan Hahn"
git config --global user.email "me@evanhahn.com"
# TODO: http://help.github.com/ignore-files/
git config --global github.user "EvanHahn"
git config --global color.ui true
git config --global core.editor "vim"

# Get GitHub set up 
# TODO: http://help.github.com/linux-set-up-git/

# Git aliases
git config --global alias.unadd "reset HEAD"
git config --global alias.statu "status"
git config --global alias.stat "status"

# Legit (git-legit.org)
if [[ `which legit` == "" ]]; then
	sudo pip install legit
	legit install
fi

# CoffeeScript and LESS and Stylus and Docco
gimme coffee npm
gimme lessc npm
gimme stylus npm
sudo easy_install Pygments
  gimme docco npm

# YEEAH DONE!
# ===========

echo "All done!"
