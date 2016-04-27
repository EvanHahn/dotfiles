if [[ -z "$PS1" ]]; then
  return # quit for non-interactive shells
fi

export PS1="
\e[00;35m\w\e[00m \u@\h
"

source "$HOME/.zsh/exports.zsh"

source "$HOME/.zsh/aliases.zsh"

if [[ "$(uname -s)" = 'Linux' ]]; then
  source "$HOME/.zsh/ubuntu.zsh"
elif [[ "$(uname -s)" = 'Darwin' ]]; then
  source "$HOME/.zsh/osx.zsh"
fi

if [[ -e "$HOME/.bashrc_local" ]]; then
  source "$HOME/.bashrc_local"
fi
