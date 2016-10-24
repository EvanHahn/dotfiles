source "$ZDOTDIR/env.zsh"

source "$ZDOTDIR/start_z.sh"

source "$ZDOTDIR/options.zsh"

source "$ZDOTDIR/aliases.zsh"

source "$ZDOTDIR/prompt.zsh"

base16_shell="$XDG_CONFIG_HOME/base16-shell"
if [ -d "$base16_shell" ]; then
  source "$base16_shell/scripts/base16-default-dark.sh"
fi
unset base16_shell

if [[ "$(uname -s)" == 'Linux' ]]; then
  source "$ZDOTDIR/linux.zsh"
elif [[ "$(uname -s)" == 'Darwin' ]]; then
  source "$ZDOTDIR/osx.zsh"
fi

if [[ -e "$HOME/.zshrc_local" ]]; then
  source "$HOME/.zshrc_local"
fi
