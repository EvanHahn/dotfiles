status --is-interactive; or exit 0

set -x PATH "$HOME/.bin" $PATH

set -x EDITOR "vim"
set -x USE_EDITOR $EDITOR
set -x VISUAL $EDITOR

if hash most ^ /dev/null
  set -x PAGER most
else if hash less ^ /dev/null
  set -x PAGER less
else if hash more ^ /dev/null
  set -x PAGER more
else
  set -x PAGER cat
end

if hash less 2>/dev/null
  set -x LESS '--ignore-case --long-prompt --QUIET --raw-control-chars --no-init'
end

set -x LS_COLORS 'di=30;46:tw=30;46:ow=30;46:ex=31:su=31:sg=31:'
set -x LSCOLORS 'afxxxxxxbxxxxxbxbxagag'
set -x GREP_OPTIONS '--color=auto'
set -x GREP_COLOR '00;36'

set fish_greeting ''

alias .. 'cd ..'
alias 2.. 'cd ../..'
alias 3.. 'cd ../../..'
alias 4.. 'cd ../../../..'

alias more $PAGER
alias less $PAGER
alias most $PAGER

alias cp 'cp -i'
alias rm 'rm -i'
alias mv 'mv -i'
alias mkdir 'mkdir -p -v'

alias lynx "lynx -cfg $HOME/.lynx.cfg"
