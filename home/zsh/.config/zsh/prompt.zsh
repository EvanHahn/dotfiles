autoload colors; colors # enable colors

setopt prompt_subst # enable hecka stuff
setopt transient_rprompt # show rprompt on current prompt only

typeset -Ag FG BG
for color in {000..255}; do
	FG[$color]="[38;5;${color}m"
	BG[$color]="[48;5;${color}m"
done
unset color

_prompt_hr() {
  local width
  local color

  width="$(echo "$(stty size)" | cut -d ' ' -f 2)"
  color="$((RANDOM % 5 + 1))"

  tput setaf "$color"
  tput setab "$color"
  seq -f '-' -s '' "$width"

  tput sgr0
}

_prompt_status_color() {
  if [[ "$?" == '0' ]]; then
    if [[ -n "$SSH_CONNECTION" ]]; then
      tput setaf 6
    else
      tput sgr0
    fi
  else
    tput setaf 1
  fi
}

PROMPT='
%{$(_prompt_hr)%}

 %{$(_prompt_status_color)%}>%{$reset_color%} '

RPROMPT='%1(j.(%j).) %{$(_prompt_status_color)%}%~%u%{$reset_color%}'
