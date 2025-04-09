alias ..='cd ..'
alias 2..='cd ../..'
alias 3..='cd ../../..'
alias 4..='cd ../../../..'
alias 5..='cd ../../../../..'

alias q='exit'

alias screen='screen -U'
alias tmux="tmux -2 -f '$XDG_CONFIG_HOME/tmux/tmux.conf'"
alias tmuxa='tmux attach || tmux new-session'

alias v="$EDITOR"
alias vi="$EDITOR"
alias vim="$EDITOR"
alias nvim="$EDITOR"

if [[ "$EDITOR" == nvim ]]; then
  alias vimdiff='nvim -d'
fi

if [ -z ${EVANHAHN_IS_SOURCING_ZSH_FROM_ANOTHER_SHELL+x} ]; then
  alias mv='nocorrect mv -i -v'
  alias cp='nocorrect cp -i -v'
  alias mkdir='nocorrect mkdir -p -v'
  alias ln='nocorrect ln -v'
fi

alias ,,='cd ..'
alias ..l='cd .. && ls'
alias :q='exit'
alias cd..='cd ..'
alias mdkir='mkdir'
alias dc='cd'
alias sl='ls'
alias sudp='sudo'

mkcd () {
  \mkdir -p "$1"
  cd "$1"
}

tempe () {
  cd "$(mktemp -d)"
  chmod -R 0700 .
  if [[ $# -eq 1 ]]; then
    \mkdir -p "$1"
    cd "$1"
    chmod -R 0700 .
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

git-fworktree () {
  cd "$(git worktree list | fzf | awk '{print $1}')"
}
