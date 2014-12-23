#!/usr/bin/env bash
set -e
set -u

if ! hash brew 2>/dev/null; then
  echo 'please install Homebrew from brew.sh'
  exit 1
fi

brew_install() {
  local already_installed="$(brew list | grep $1 | wc -l | awk '{print $1}')"
  if [ "$already_installed" == '0' ]; then
    echo -n "$1? "
    read skip
    if [ "$skip" == '' ]; then
      brew install $@
    fi
  fi
}

brew_cask_install() {
  local already_installed="$(brew cask list | grep $1 | wc -l | awk '{print $1}')"
  if [ "$already_installed" == '0' ]; then
    echo -n "$1? "
    read skip
    if [ "$skip" == '' ]; then
      brew cask install $@
    fi
  fi
}

brew_tap() {
  local already_tapped="$(brew tap | grep $1 | wc -l | awk '{print $1}')"
  if [ "$already_tapped" == '0' ]; then
    brew tap $@
  fi
}

# up to date?
brew update
brew upgrade

# cask
cask_not_installed="$(brew info 'caskroom/cask/brew-cask' | grep 'Not installed' | wc -l | awk '{print $1}')"
if [ "$cask_not_installed" == '1' ]; then
  brew install caskroom/cask/brew-cask
fi

# taps
brew_tap homebrew/games
brew_tap caskroom/fonts

# replacements
brew_install bash
brew_install vim
brew_install zsh
brew_install git

# the rest of the command line
brew_install ffmpeg --with-faac --with-fdk-aac --with-ffplay --with-fontconfig --with-freetype --with-frei0r --with-libass --with-libbluray --with-libcaca --with-libquvi --with-libsoxr --with-libvidstab --with-libvorbis --with-libvpx --with-opencore-amr --with-openjpeg --with-openssl --with-opus --with-rtmpdump --with-schroedinger --with-speex --with-theora --with-x265
brew_install lua
brew_install lynx
brew_install mobile-shell
brew_install most
brew_install naga
brew_install pianobar
brew_install reattach-to-user-namespace
brew_install ruby
brew_install tmux
brew_install trash
brew_install vitetris
brew_install youtube-dl
brew_install spoof-mac

# apps
brew_cask_install alfred
brew_cask_install atom
brew_cask_install brightness
brew_cask_install chromium
brew_cask_install cloud
brew_cask_install dash
brew_cask_install dropbox
brew_cask_install firefox
brew_cask_install flux
brew_cask_install gitx
brew_cask_install handbrake
brew_cask_install iterm2
brew_cask_install macdown
brew_cask_install openemu
brew_cask_install paintbrush
brew_cask_install proxpn
brew_cask_install rdio
brew_cask_install skype
brew_cask_install spectacle
brew_cask_install spideroak
brew_cask_install the-unarchiver
brew_cask_install vlc

# fonts
brew_cask_install font-lato
brew_cask_install font-open-sans
brew_cask_install font-source-code-pro

brew_cask_install bee
