# Organinized to match the [Z Shell Manual's "Options" chapter][0].
# [0]: https://zsh.sourceforge.io/Doc/Release/Options.html

# "Changing Directories"

setopt no_auto_cd
setopt auto_pushd
setopt cd_silent
setopt no_cdable_vars
setopt no_chase_dots
setopt no_chase_links
setopt no_posix_cd
setopt pushd_ignore_dups
setopt pushd_minus
setopt pushd_silent
setopt pushd_to_home

# "Completion"
# See also: ["Completion, old and new"][1].
# [1]: https://zsh.sourceforge.io/Guide/zshguide06.html

bindkey '^i' complete-word

setopt always_to_end
setopt auto_list
setopt auto_menu
setopt auto_param_keys
setopt auto_param_slash
setopt auto_remove_slash
setopt complete_in_word
setopt glob_complete
setopt list_ambiguous
setopt list_beep
setopt no_list_packed
setopt list_types
setopt no_menu_complete
setopt no_rec_exact

# "Expansion and Globbing"
# See also: ["Expansion"][2].
# [2]: https://zsh.sourceforge.io/Doc/Release/Expansion.html#Brace-Expansion

setopt bad_pattern
setopt no_bare_glob_qual
setopt no_brace_ccl
setopt no_case_glob
setopt case_match
setopt no_equals
setopt no_extended_glob
setopt no_force_float
setopt glob
setopt no_glob_assign
setopt no_glob_dots
setopt no_glob_star_short
setopt no_hist_subst_pattern
setopt no_ignore_braces
setopt no_ksh_glob
setopt multibyte
setopt nomatch
setopt numeric_glob_sort
setopt no_rc_expand_param
setopt sh_glob
setopt no_unset

# "History"

bindkey '\C-r' history-incremental-search-backward

setopt extended_history
setopt no_hist_beep
setopt hist_expire_dups_first
setopt hist_fcntl_lock
setopt hist_find_no_dups
setopt no_hist_ignore_all_dups
setopt hist_ignore_dups
setopt no_hist_ignore_space
setopt hist_no_functions
setopt hist_reduce_blanks
setopt no_hist_save_no_dups
setopt no_inc_append_history
setopt share_history

# "Initialisation"
# See also: ["Files"][3].
# [3]: https://zsh.sourceforge.io/Doc/Release/Files.html#Files

setopt no_all_export
setopt no_global_rcs
setopt rcs

# "Input/Output"

setopt aliases
setopt no_clobber
setopt clobber_empty
setopt no_correct
setopt no_correctall
setopt no_dvorak
setopt no_flow_control
setopt no_hash_cmds
setopt no_ignore_eof
setopt interactive_comments
setopt mail_warning
setopt no_path_dirs
setopt no_print_exit_value
setopt rc_quotes
setopt no_rm_star_silent
setopt no_rm_star_wait
setopt short_loops
setopt short_repeat
setopt no_sun_keyboard_hack

# "Job Control"

setopt no_auto_continue
setopt no_auto_resume
setopt bg_nice
setopt check_jobs
setopt check_running_jobs
setopt hup
setopt notify

# "Prompting"
# See `prompt.zsh`.

# "Scripts and Functions"

setopt no_alias_func_def
setopt c_bases
setopt c_precedences
setopt no_debug_before_cmd
setopt no_err_exit
setopt no_err_return
setopt no_multi_func_def
setopt multios
setopt no_octal_zeroes
setopt pipe_fail
setopt no_typeset_silent

# "Shell Emulation"

setopt append_create
setopt no_bsd_echo
setopt no_continue_on_error
setopt no_csh_junkie_loops
setopt no_csh_junkie_quotes
setopt no_csh_nullcmd
setopt no_ksh_arrays
setopt no_ksh_autoload
setopt no_ksh_option_print
setopt no_ksh_zero_subscript
setopt posix_aliases
setopt posix_builtins
setopt posix_identifiers
setopt no_posix_strings

# "Zle"

setopt beep
setopt combining_chars
setopt no_emacs
setopt vi
setopt zle
