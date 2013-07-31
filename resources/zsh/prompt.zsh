autoload colors; colors # enable colors

setopt prompt_subst # enable hecka stuff

setopt transient_rprompt # show rprompt on current prompt only

typeset -Ag FG BG
for color in {000..255}; do
	FG[$color]="[38;5;${color}m"
	BG[$color]="[48;5;${color}m"
done

PROMPT='
%{$BG[233]%}%{$fg[red]%} %~ %E%{$reset_color%}
%{$FG[240]%}▶%{$reset_color%} '

RPROMPT='%{$FG[240]%}%t%{$reset_color%}'
