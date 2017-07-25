source "$ZDOTDIR/env.zsh"

source "$ZDOTDIR/start_z.sh"

source "$ZDOTDIR/options.zsh"

source "$ZDOTDIR/aliases.zsh"

source "$ZDOTDIR/prompt.zsh"

if [[ "$(uname -s)" == 'Linux' ]]; then
  source "$ZDOTDIR/linux.zsh"
elif [[ "$(uname -s)" == 'Darwin' ]]; then
  source "$ZDOTDIR/osx.zsh"
fi

if [[ -e "$HOME/.zshrc_local" ]]; then
  source "$HOME/.zshrc_local"
fi
