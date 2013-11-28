export HISTSIZE=32768 # larger history
export HISTFILESIZE=$HISTSIZE
shopt -s histappend # append to history
export HISTCONTROL=ignoredups

set +o histexpand
