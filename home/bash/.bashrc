if [[ -z "$PS1" ]]; then
  return # quit for non-interactive shells
fi

export PS1='
 \w > '

if [[ -e "$HOME/.bashrc_local" ]]; then
  source "$HOME/.bashrc_local"
fi
