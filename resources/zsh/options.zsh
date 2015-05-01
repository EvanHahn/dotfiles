bindkey '\C-r' history-incremental-search-backward

# these are in the order that they are in the ZSH docs
# <http://zsh.sourceforge.net/Doc/Release/Options.html>

setopt auto_cd
setopt cdable_vars
setopt chase_links
# setopt no_posix_cd
setopt pushd_ignore_dups
setopt pushd_minus
setopt pushd_silent
setopt pushd_to_home

setopt always_to_end
setopt no_auto_list
setopt auto_menu
setopt auto_param_slash
setopt complete_in_word
setopt no_list_beep
setopt no_menu_complete

setopt bad_pattern
setopt no_case_glob
setopt no_case_match
setopt no_csh_null_glob
setopt no_extended_glob
setopt glob
setopt glob_assign
setopt no_glob_dots
# setopt no_ignore_close_braces
setopt no_ksh_glob
setopt magic_equal_subst
setopt numeric_glob_sort
setopt no_rc_expand_param
setopt warn_create_global

export HISTFILE="$HOME/.zsh_history"
setopt append_history
setopt extended_history
setopt no_hist_beep
setopt hist_expire_dups_first
setopt hist_find_no_dups
setopt no_hist_ignore_all_dups
setopt hist_ignore_dups
setopt no_hist_ignore_space
setopt hist_no_functions
setopt no_hist_no_store
setopt hist_verify
setopt inc_append_history

setopt rcs

setopt aliases
setopt no_clobber
setopt correct
setopt correctall
setopt no_dvorak
setopt no_ignore_eof
setopt interactive_comments
setopt mail_warning
setopt no_path_dirs
setopt no_rm_star_silent
setopt rm_star_wait
setopt no_sun_keyboard_hack

setopt bg_nice
setopt no_hup
setopt notify

setopt no_bsd_echo
setopt no_csh_junkie_quotes # to avoid breaking my prompt and Z.sh
setopt posix_aliases

setopt no_beep
setopt vi
