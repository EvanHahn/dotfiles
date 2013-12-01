export LANG="en_US.utf8"
export LANGUAGE="en_US.utf8"

setopt auto_cd # don't type cd
setopt cdablevarS # smarter cd -- go wherever
setopt pushd_ignore_dups # ignore duplicates

setopt EXTENDED_GLOB # case insensitive, oh my glob
unsetopt CASE_GLOB

HISTSIZE=10000
SAVEHIST=9000
HISTFILE=~/.zsh_history
setopt append_history # one zsh history to rule them all
setopt extended_history # save time metadata
setopt inc_append_history # add to history as soon as it happens
setopt hist_expire_dups_first # lose oldest duplicates first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_find_no_dups
setopt hist_reduce_blanks
setopt hist_verify # just expand history

unsetopt beep
unsetopt hist_beep
unsetopt list_beep

setopt rm_star_wait # are you sure you want to rm *?

setopt interactivecomments # comments in the CLI

setopt correct # spellcheck errywhere
setopt correctall

setopt always_to_end # move cursor to end of completion
setopt auto_menu # show completion menu
setopt auto_list # always show the completion list
unsetopt menu_complete # don't autoselect first completion entry
setopt auto_name_dirs # any parameter that is set to the absolute name of a directory immediately becomes a name for that directory
setopt complete_in_word # completion from within a word/phrase

setopt bg_nice # background jobs at lower priority

SPROMPT='When you said "%R", did you mean "%r"? '

export EDITOR=vim
export USE_EDITOR=$EDITOR
export VISUAL=$EDITOR

export CLICOLOR=1
export LS_COLORS="Gxxxxxxxbxegedabagacad"
export LSCOLORS=$LS_COLORS # OSX support

export GREP_OPTIONS='--color=auto'
export GREP_COLOR=32

set +o histexpand

if [[ -x $(which less 2> /dev/null) ]]; then
	export PAGER="less"
	export LESS="--ignore-case --long-prompt --QUIET --raw-control-chars --quit-if-one-screen --no-init"
fi

eval "$(npm completion 2>/dev/null)" # npm completion

bindkey '^R' history-incremental-search-backward
