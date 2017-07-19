alias random="$DOTFILES_HOME/resources/bin/el-rando/el-rando.py"
alias is-github-up="$DOTFILES_HOME/resources/bin/is_github_up/is_github_up.rb"
alias iscp="$DOTFILES_HOME/resources/bin/iscp/iscp.sh"
alias journ="$DOTFILES_HOME/resources/bin/journ/journ"
alias rename="$DOTFILES_HOME/resources/bin/rename/rename.sh"

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
if hash colordiff 2>/dev/null; then
  alias diff=colordiff
fi

alias mv='nocorrect mv -i -v'
alias cp='nocorrect cp -i -v'
alias mkdir='nocorrect mkdir -p -v'
alias ln='nocorrect ln -v'

alias please='sudo --set-home "$(fc -ln -1)"'

alias ,,='cd ..'
alias ..l='cd .. && ls'
alias :q='exit'
alias cd..='cd ..'
alias gits='git s'
alias gs='git s'
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
