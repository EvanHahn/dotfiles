# require an interactive shell

if [[ -z "$PS1" ]]; then return; fi

# bash-specific options

export PS1='
\w > '
export BASH_SILENCE_DEPRECATION_WARNING=1

# lift most things from zsh

if [[ -e "$HOME/.zshenv" ]]; then
  export EVANHAHN_IS_SOURCING_ZSH_FROM_ANOTHER_SHELL=1

  source "$HOME/.zshenv"

  source "$ZDOTDIR/env.zsh"

  source "$ZDOTDIR/aliases.zsh"

  if [[ "$(uname -s)" == 'Linux' ]]; then
    source "$ZDOTDIR/linux.zsh"
  elif [[ "$(uname -s)" == 'Darwin' ]]; then
    source "$ZDOTDIR/mac.zsh"
  fi

  unset EVANHAHN_IS_SOURCING_ZSH_FROM_ANOTHER_SHELL
fi

# local bashrc

if [[ -e "$HOME/.bashrc_local" ]]; then
  source "$HOME/.bashrc_local"
fi
