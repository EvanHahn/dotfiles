#!/usr/bin/env ruby
require 'json'

###

$commands = []

###

def mac?
  RUBY_PLATFORM.include? 'darwin'
end

def linux?
  RUBY_PLATFORM.include? 'linux'
end

def brew_installed?
  `which brew` != ''
end

def installed_brews
  if brew_installed?
    `brew list`.split("\n")
  else
    []
  end
end

def installed_casks
  if installed_brews.include? 'brew-cask'
    `brew cask list`.split("\n")
  else
    []
  end
end

def installed_apts
  if linux?
    list = `apt list --installed`.split("\n")
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

def installed_npms
  if installed_brews.include? 'node'
    deps = `npm ls -g --depth 0 --json`
    JSON.parse(deps)['dependencies'].keys
  else
    []
  end
end

def installed_taps
  if brew_installed?
    `brew tap`.split("\n")
  else
    []
  end
end

###

def install(list, command, existing, command_suffix = '')
  list.each do |package|
    name = package.split.first
    unless existing.include? name
      print "install #{name}? "
      go_ahead = ['', 'y', 'yes', 'yas'].include? gets.strip.downcase
      $commands.push "#{command} #{package} #{command_suffix}" if go_ahead
    end
  end
end

###

# what are we installing

TAPS = [
  'homebrew/games',
  'caskroom/fonts'
]

BREWS = [
  # replacements
  'bash',
  'git --with-brewed-curl --with-brewed-openssl --with-brewed-svn',
  'python',
  'ruby',
  'vim --with-client-server --with-lua',
  'zsh',

  # other CLI
  'colordiff',
  'ctags',
  'duti',
  'ffmpeg --with-faac --with-fdk-aac --with-ffplay --with-fontconfig --with-freetype --with-frei0r --with-libass --with-libbluray --with-libcaca --with-libquvi --with-libsoxr --with-libvidstab --with-libvorbis --with-libvpx --with-opencore-amr --with-openjpeg --with-openssl --with-opus --with-rtmpdump --with-schroedinger --with-speex --with-theora --with-x265',
  'lynx',
  'node --with-debug --with-openssl',
  'reattach-to-user-namespace',
  'shellcheck',
  'spoof-mac',
  'stow',
  'tmux',
  'trash',
  'vimpager',
  'vitetris',
  'watch',
  'youtube-dl',
  'z'
]

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
  'handbrake',
  'imagealpha',
  'imageoptim',
  'iterm2',
  'keka',
  'macdown',
  'openemu',
  'paintbrush',
  'phoenix',
  'proxpn',
  'skype',
  'spideroak',
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
  'compton',
  'firefox',
  'git',
  'handbrake',
  'redshift',
  'ruby',
  'vim',
  'vlc',
  'xclip',
  'xorg',
  'zsh'
]

GEMS = []

PIPS = [
  'emo',
  'flake8',
  'pushbullet-cli',
  'pygments'
]

NPMS = [
  'github-upstreamer',
  'jsonlint',
  'standard',
  'vtop'
]

# do the installation

if mac?
  if !brew_installed?
    echo 'please install homebrew'
    exit 1
  else
    $commands.push 'brew update'
    $commands.push 'brew upgrade --all'
  end

  install TAPS, 'brew tap', installed_taps

  install BREWS, 'brew install', installed_brews

  install CASKS, 'brew cask install', installed_casks
end

if linux?
  $commands.push 'sudo apt-get update'
  $commands.push 'sudo apt-get upgrade -y'

  install APTS, 'sudo apt-get install', installed_apts, '-y'
end

install GEMS, 'gem install', installed_gems

install PIPS, 'pip install', installed_pips

install NPMS, 'npm install -g', installed_npms

puts
puts "alright let's do this"
puts

$commands.each do |command|
  system command
end
