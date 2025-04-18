PROMPT='%0(?..%F{red})%S > %f%s '
RPROMPT=' %0(?..%F{red})%S %B%~%b%1(j. (%j).) %f%s'

if hash fzf 2>/dev/null; then
  source <(fzf --zsh)
fi
