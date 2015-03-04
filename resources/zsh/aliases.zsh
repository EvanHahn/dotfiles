alias .='pwd'
alias ..='cd ..'
alias 2..='cd ../..'
alias 3..='cd ../../..'
alias 4..='cd ../../../..'
alias 5..='cd ../../../../..'

alias q='exit'

alias bell='tput bel'

alias more="$PAGER"
alias less="$PAGER"
alias most="$PAGER"
alias vimpager="$PAGER"
alias nvim="$EDITOR"
alias vim="$EDITOR"
alias vi="$EDITOR"
alias emacs="$EDITOR"
alias nano="$EDITOR"

if hash colordiff 2>/dev/null; then
  alias diff=colordiff
fi

alias ed='ed -p:'
alias lynx="lynx -cfg $HOME/.lynx.cfg"
alias screen='screen -U'
alias tmux='tmux -u2'

if [[ "$SHELL" == "$(which zsh)" ]]; then

  alias mv='nocorrect mv -i -v'
  alias cp='nocorrect cp -i -v'
  alias mkdir='nocorrect mkdir -p -v'
  alias ln='nocorrect ln -v'

  alias please='sudo $(fc -ln -1)'

fi

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
