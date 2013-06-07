setopt auto_cd # Don't type cd
setopt cdablevarS # Smarter cd -- go wherever
setopt pushd_ignore_dups # Ignore duplicates

HISTSIZE=10000
SAVEHIST=9000
HISTFILE=~/.zsh_history
setopt append_history # One zsh history to rule them all
setopt extended_history # Save time metadata
setopt inc_append_history # Add to history as soon as it happens
setopt hist_expire_dups_first # Lose oldest duplicates first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_find_no_dups
setopt hist_reduce_blanks
setopt hist_verify # Just expand history

setopt no_beep

setopt rm_star_wait # Are you sure you want to rm *?

setopt correct # Spellcheck errywhere
setopt correctall
setopt always_to_end # Move cursor to end of completion
setopt auto_menu # Show completion menu
setopt menu_complete # Don't autoselect first completion entry
setopt auto_name_dirs # Any parameter that is set to the absolute name of a directory immediately becomes a name for that directory
setopt complete_in_word # Completion from within a word/phrase

export EDITOR=vim
