#!/usr/bin/env ruby

# what are we installing

TAPS = [
  'homebrew/games',
  'caskroom/fonts'
]

BREWS = [
  # replacements
  'bash',
  'git',
  'ruby',
  'vim',
  'zsh',

  # other CLI
  'aspell --with-lang-en',
  'ffmpeg --with-faac --with-fdk-aac --with-ffplay --with-fontconfig --with-freetype --with-frei0r --with-libass --with-libbluray --with-libcaca --with-libquvi --with-libsoxr --with-libvidstab --with-libvorbis --with-libvpx --with-opencore-amr --with-openjpeg --with-openssl --with-opus --with-rtmpdump --with-schroedinger --with-speex --with-theora --with-x265',
  'lua',
  'lynx',
  'mobile-shell',
  'naga',
  'pianobar',
  'reattach-to-user-namespace',
  'screenbrightness',
  'spoof-mac',
  'tmux',
  'trash',
  'vimpager',
  'vitetris',
  'youtube-dl'
]

CASKS = [
  'alfred',
  'atom',
  'brightness',
  'chromium',
  'cloud',
  'dash',
  'dropbox',
  'firefox',
  'flux',
  'gitx',
  'handbrake',
  'iterm2',
  'macdown',
  'openemu',
  'paintbrush',
  'proxpn',
  'rdio',
  'skype',
  'spectacle',
  'spideroak',
  'the-unarchiver',
  'vlc',

  # fonts
  'font-fredoka-one',
  'font-lato',
  'font-open-sans',
  'font-source-code-pro',

  # quicklook plugins
  'qlcolorcode',
  'qlmarkdown',
  'qlstephen',
  'quicklook-csv',
  'quicklook-json',
  'webpquicklook',

  # other plugins and non-apps
  'google-hangouts'
]

GEMS = [
  'delicious-cli',
  'rdio-cli'
]

# do the installation

if `which brew` == ''
  puts `ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`
end

INSTALLED_BREWS = `brew list`.split("\n")
if INSTALLED_BREWS.include? 'brew-cask'
  INSTALLED_CASKS = `brew cask list`.split("\n")
else
  INSTALLED_CASKS = []
end
INSTALLED_GEMS = `gem list --no-versions`.split("\n")
INSTALLED_TAPS = `brew tap`.split("\n")

$command_queue = ['brew update']
unless INSTALLED_BREWS.include? 'brew-cask'
  $command_queue.push "brew install caskroom/cask/brew-cask"
end

def install(list, command, existing)
  list.each do |package|
    name = package.split.first
    unless existing.include? name
      print "install #{name}? "
      skip_cmd = gets.strip
      go_ahead = (skip_cmd == 'y') || (skip_cmd == 'yes') || (skip_cmd == '')
      $command_queue.push "#{command} #{package}" if go_ahead
    end
  end
end

install TAPS, "brew tap", INSTALLED_TAPS
install BREWS, "brew install", INSTALLED_BREWS
install CASKS, "brew cask install", INSTALLED_CASKS
install GEMS, "gem install", INSTALLED_GEMS

$command_queue.each do |command|
  system command
end
