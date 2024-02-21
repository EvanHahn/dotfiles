# require an interactive shell

if [[ -z "$PS1" ]]; then return; fi

# bash-specific options

export PS1='
\w > '
export BASH_SILENCE_DEPRECATION_WARNING=1

# lift most things from zsh

if [[ -e "$HOME/.zshenv" ]]; then
  source "$HOME/.zshenv"

  source "$ZDOTDIR/env.zsh"

  source "$ZDOTDIR/aliases.zsh"

  if [[ "$(uname -s)" == 'Linux' ]]; then
    source "$ZDOTDIR/linux.zsh"
  elif [[ "$(uname -s)" == 'Darwin' ]]; then
    source "$ZDOTDIR/mac.zsh"
  fi
fi

# local bashrc

if [[ -e "$HOME/.bashrc_local" ]]; then
  source "$HOME/.bashrc_local"
fi
