# TODO
# source "$HOME/.bin/start_z"

source "$ZDOTDIR/options.zsh"

source "$ZDOTDIR/aliases.zsh"

source "$ZDOTDIR/prompt.zsh"

if [[ "$(uname -s)" == 'Linux' ]]; then
  source "$ZDOTDIR/ubuntu.zsh"
elif [[ "$(uname -s)" == 'Darwin' ]]; then
  source "$ZDOTDIR/osx.zsh"
fi

if [[ -e "$HOME/.zshrc_local" ]]; then
  source "$HOME/.zshrc_local"
fi
