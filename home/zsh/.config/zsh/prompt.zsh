autoload colors; colors # enable colors

setopt prompt_subst # enable hecka stuff
setopt transient_rprompt # show rprompt on current prompt only

_prompt_hr() {
  local width

  width="$(echo "$(stty size)" | cut -d ' ' -f 2)"

  printf '–%.0s' {1..$width}
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
 > '

RPROMPT='%1(j.(%j).) %{$(_prompt_status_color)%}%~%u%{$reset_color%}'
