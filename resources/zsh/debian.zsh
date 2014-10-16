alias open='xdg-open'

alias ls='ls --color'

alias e='gvim'

alias pingo='ping -c 1 74.125.225.36 | grep -v transmitted | grep time'

alias reboot='sudo reboot'

trash () {
  if hash trash 2>/dev/null; then
    trash $@
  else
    local trash='$HOME/.Trash'
    if [[ ! -d '$trash' ]]; then
      mkdir '$trash'
    fi
    mv '$1' '$trash'
  fi
}

brew () {
  if [ $# == 0 ]; then
    apt-get
  elif [ $1 == 'info' ]; then
    apt show $2
  elif [ $1 == 'install' -o $1 == 'upgrade' ]; then
    sudo apt-get $@ -y
  else
    sudo apt-get $@
  fi
}
