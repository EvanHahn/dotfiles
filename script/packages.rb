#!/usr/bin/env ruby

def is_mac?
  RUBY_PLATFORM.include? 'darwin'
end

def is_linux?
  RUBY_PLATFORM.include? 'linux'
end

def ensure_brew_is_installed
  if `which brew` == ''
    if is_mac?
      puts `ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`
    elsif is_linux?
      puts `sudo apt-get install build-essential curl git m4 texinfo libbz2-dev libcurl4-openssl-dev libexpat-dev libncurses-dev zlib1g-dev -y`
      puts `ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/linuxbrew/go/install)"`
    end
  end
end

def installed_brews
  ensure_brew_is_installed
  `brew list`.split("\n")
end

def installed_casks
  if installed_brews.include? 'brew-cask'
    `brew cask list`.split("\n")
  else
    []
  end
end

def installed_apts
  if is_linux?
    list = `apt list --installed`
    list.shift
    list.map { |p| p.match('^[^\/]+')[0] }
  else
    []
  end
end

def installed_gems
  `gem list --no-versions`.split("\n")
end

def installed_pips
  if installed_brews.include? 'python'
    `pip list`.split("\n").map { |p| p.split[0].downcase }
  else
    []
  end
end

def installed_taps
  `brew tap`.split("\n")
end

# what are we installing

TAPS = [
  'homebrew/games'
]
TAPS << 'caskroom/fonts' if is_mac?

BREWS = [
  # replacements
  'bash',
  'git --with-brewed-curl --with-brewed-openssl --with-brewed-svn',
  'python',
  'ruby',
  'vim --with-client-server --with-lua',
  'zsh',

  # other CLI
  'aspell --with-lang-en',
  'colordiff',
  'dict',
  'ffmpeg --with-faac --with-fdk-aac --with-ffplay --with-fontconfig --with-freetype --with-frei0r --with-libass --with-libbluray --with-libcaca --with-libquvi --with-libsoxr --with-libvidstab --with-libvorbis --with-libvpx --with-opencore-amr --with-openjpeg --with-openssl --with-opus --with-rtmpdump --with-schroedinger --with-speex --with-theora --with-x265',
  'lynx',
  'mobile-shell',
  'naga',
  'node --with-debug --with-icu4c --with-openssl',
  'pianobar',
  'redshift',
  'spoof-mac',
  'tmux',
  'vimpager',
  'vitetris',
  'youtube-dl',
  'z'
]
if is_mac?
  BREWS << 'reattach-to-user-namespace'
  BREWS << 'screenbrightness'
  BREWS << 'trash'
end

CASKS = [
  'alfred',
  'appcleaner',
  'atom',
  'audio-hijack',
  'brightness',
  'chromium',
  'cloud',
  'dash',
  'firefox',
  'gitx',
  'handbrake',
  'imageoptim',
  'iterm2',
  'keka',
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
  'font-inconsolata',
  'font-lato',
  'font-open-sans',

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

APTS = [
  'chromium-browser',
  'firefox',
  'gitk',
  'handbrake',
  'vlc'
]

GEMS = [
  'delicious-cli',
]
GEMS << 'rdio-cli' if is_mac?

PIPS = [
  'flake8',
  'pygments',
  'emo'
]

# do the installation

ensure_brew_is_installed

$command_queue = [
  'brew update',
  'brew upgrade'
]

if is_mac?
  if !installed_brews.include?('brew-cask')
    $command_queue << 'brew install caskroom/cask/brew-cask'
  end
elsif is_linux?
  $command_queue << 'sudo apt-get update -y'
  $command_queue << 'sudo apt-get upgrade -y'
end

def install(list, command, existing, command_suffix='')
  list.each do |package|
    name = package.split.first
    unless existing.include? name
      print "install #{name}? "
      go_ahead = ['', 'y', 'yes', 'yas'].include? gets.strip.downcase
      $command_queue.push "#{command} #{package} #{command_suffix}" if go_ahead
    end
  end
end

install TAPS, 'brew tap', installed_taps

install BREWS, 'brew install', installed_brews

install(CASKS, 'brew cask install', installed_casks) if is_mac?
install(APTS, 'sudo apt-get install', installed_apts, '-y') if is_linux?

install GEMS, 'gem install', installed_gems

install PIPS, 'pip install', installed_pips

puts
puts "alright let's do this"
puts

$command_queue.each do |command|
  system command
end
