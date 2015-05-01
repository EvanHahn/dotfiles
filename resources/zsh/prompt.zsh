autoload colors; colors # enable colors

setopt prompt_subst # enable hecka stuff
setopt transient_rprompt # show rprompt on current prompt only

typeset -Ag FG BG
for color in {000..255}; do
	FG[$color]="[38;5;${color}m"
	BG[$color]="[48;5;${color}m"
done

_prompt_status_color() {
  if [[ "$?" == '0' ]]; then
    echo -e "$FG[240]"
  else
    echo -e "$FG[160]"
  fi
}

PROMPT='
 %{$(_prompt_status_color)%}>%{$reset_color%} '

RPROMPT='%{$FG[163]%}%~%u%{$reset_color%} %{$(_prompt_status_color)%}<%{$reset_color%} '

SPROMPT="%{$FG[240]%}when you said %{$FG[230]%}%R%{$FG[240]%}, did you mean %{$FG[228]%}%r%{$FG[240]%}?%{$reset_color%} "
