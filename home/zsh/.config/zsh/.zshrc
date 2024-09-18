source "$ZDOTDIR/env.zsh"

source "$ZDOTDIR/options.zsh"

source "$ZDOTDIR/aliases.zsh"

source "$ZDOTDIR/prompt.zsh"

if [[ "$(uname -s)" == 'Linux' ]]; then
  source "$ZDOTDIR/linux.zsh"
elif [[ "$(uname -s)" == 'Darwin' ]]; then
  source "$ZDOTDIR/mac.zsh"
fi

if [[ -e "$HOME/.zshrc_local" ]]; then
  source "$HOME/.zshrc_local"
fi

if [[ -z ${TMUX+x} ]]; then
  tmux attach || tmux new-session
fi
