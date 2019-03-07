alias .='pwd'
alias ..='cd ..'
alias 2..='cd ../..'
alias 3..='cd ../../..'
alias 4..='cd ../../../..'
alias 5..='cd ../../../../..'

alias q='exit'

alias ed='ed -p:'
alias screen='screen -U'
alias tmux="tmux -u2 -f '$XDG_CONFIG_HOME/tmux/tmux.conf'"
alias tmuxa='tmux a || tmux'

alias v="$EDITOR"
alias vi="$EDITOR"
alias vim="$EDITOR"
alias nvim="$EDITOR"

alias mv='nocorrect mv -i -v'
alias cp='nocorrect cp -i -v'
alias mkdir='nocorrect mkdir -p -v'
alias ln='nocorrect ln -v'

alias ,,='cd ..'
alias ..l='cd .. && ls'
alias :q='exit'
alias cd..='cd ..'
alias gut='git'
alias mdkir='mkdir'
alias npmi='npm i'
alias npmt='npm t'
alias sl='ls'
alias sudp='sudo'
alias snippet='snippets'

tempe () {
  cd "$(mktemp -d)"
  if [[ $# -eq 1 ]]; then
    \mkdir -p "$1"
    cd "$1"
  fi
}

boop () {
  local last="$?"
  if [[ "$last" == '0' ]]; then
    sfx good
  else
    sfx bad
  fi
  $(exit "$last")
}
