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
