autoload colors; colors # Enable colors

setopt prompt_subst # Enable hecka stuff

setopt transient_rprompt # Show rprompt on current prompt only

typeset -Ag FG BG
for color in {000..255}; do
	FG[$color]="[38;5;${color}m"
	BG[$color]="[48;5;${color}m"
done

PROMPT='
%{$BG[233]%}%{$fg[red]%} %~ %E%{$reset_color%}
%{$FG[240]%}▶%{$reset_color%} '

RPROMPT='%{$FG[240]%}%t%{$reset_color%}'
