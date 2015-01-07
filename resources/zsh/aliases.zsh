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
alias vim="$EDITOR"
alias vi="$EDITOR"
alias emacs="$EDITOR"
alias nano="$EDITOR"

alias ed='ed -p:'
alias lynx="lynx -cfg $HOME/.lynx.cfg"
alias screen='screen -U'
alias tmux='tmux -u2'

if [[ "$SHELL" == "$(which zsh)" ]]; then
  alias mv='nocorrect mv -i -v'
  alias cp='nocorrect cp -i -v'
  alias mkdir='nocorrect mkdir -p -v'
  alias ln='nocorrect ln -v'
fi

alias ,,='cd ..'
alias ..l='cd .. && ls'
alias :q='exit'
alias cd..='cd ..'
alias gits='git s'
alias gs='git s'
alias gut='git'
alias mdkir='mkdir'
alias sl='ls'
alias sudp='sudo'
