if [[ -z "$PS1" ]]; then
  return # quit for non-interactive shells
fi

sourceif () {
  if [[ -e "$1" ]]; then
    source "$1"
  fi
}

export PS1='
 \w > '

sourceif "$HOME/.zshenv"
sourceif "$HOME/.config/aliases.zsh"
sourceif "$HOME/.config/env.zsh"
sourceif "$HOME/.config/start_z.sh"
sourceif "$HOME/.bashrc_local"
