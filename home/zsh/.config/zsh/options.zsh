# Organinized to match the [Z Shell Manual's "Options" chapter][0].
# [0]: https://zsh.sourceforge.io/Doc/Release/Options.html

# If I'm on an older version of ZSH, I don't want an error message.
# This only sets options that exist.

setopt_if_exists() {
  if [[ "${options[$1]+1}" ]]; then
    setopt "$1"
  fi
}

# "Changing Directories"

setopt_if_exists no_auto_cd
setopt_if_exists auto_pushd
setopt_if_exists cd_silent
setopt_if_exists no_cdable_vars
setopt_if_exists no_chase_dots
setopt_if_exists no_chase_links
setopt_if_exists no_posix_cd
setopt_if_exists pushd_ignore_dups
setopt_if_exists pushd_minus
setopt_if_exists pushd_silent
setopt_if_exists pushd_to_home

# "Completion"
# See also: ["Completion, old and new"][1].
# [1]: https://zsh.sourceforge.io/Guide/zshguide06.html

bindkey '^i' complete-word

setopt_if_exists always_to_end
setopt_if_exists auto_list
setopt_if_exists auto_menu
setopt_if_exists auto_param_keys
setopt_if_exists auto_param_slash
setopt_if_exists auto_remove_slash
setopt_if_exists complete_in_word
setopt_if_exists glob_complete
setopt_if_exists list_ambiguous
setopt_if_exists list_beep
setopt_if_exists no_list_packed
setopt_if_exists list_types
setopt_if_exists no_menu_complete
setopt_if_exists no_rec_exact

# "Expansion and Globbing"
# See also: ["Expansion"][2].
# [2]: https://zsh.sourceforge.io/Doc/Release/Expansion.html#Brace-Expansion

setopt_if_exists bad_pattern
setopt_if_exists no_bare_glob_qual
setopt_if_exists no_brace_ccl
setopt_if_exists no_case_glob
setopt_if_exists case_match
setopt_if_exists no_equals
setopt_if_exists no_extended_glob
setopt_if_exists no_force_float
setopt_if_exists glob
setopt_if_exists no_glob_assign
setopt_if_exists no_glob_dots
setopt_if_exists no_glob_star_short
setopt_if_exists no_hist_subst_pattern
setopt_if_exists no_ignore_braces
setopt_if_exists no_ksh_glob
setopt_if_exists multibyte
setopt_if_exists nomatch
setopt_if_exists numeric_glob_sort
setopt_if_exists no_rc_expand_param
setopt_if_exists sh_glob
setopt_if_exists no_unset

# "History"

bindkey '\C-r' history-incremental-search-backward

setopt_if_exists extended_history
setopt_if_exists no_hist_beep
setopt_if_exists hist_expire_dups_first
setopt_if_exists hist_fcntl_lock
setopt_if_exists hist_find_no_dups
setopt_if_exists no_hist_ignore_all_dups
setopt_if_exists hist_ignore_dups
setopt_if_exists no_hist_ignore_space
setopt_if_exists hist_no_functions
setopt_if_exists hist_reduce_blanks
setopt_if_exists no_hist_save_no_dups
setopt_if_exists no_inc_append_history
setopt_if_exists share_history

# "Initialisation"
# See also: ["Files"][3].
# [3]: https://zsh.sourceforge.io/Doc/Release/Files.html#Files

setopt_if_exists no_all_export
setopt_if_exists no_global_rcs
setopt_if_exists rcs

# "Input/Output"

setopt_if_exists aliases
setopt_if_exists no_clobber
setopt_if_exists clobber_empty
setopt_if_exists no_correct
setopt_if_exists no_correctall
setopt_if_exists no_dvorak
setopt_if_exists no_flow_control
setopt_if_exists no_hash_cmds
setopt_if_exists no_ignore_eof
setopt_if_exists interactive_comments
setopt_if_exists mail_warning
setopt_if_exists no_path_dirs
setopt_if_exists no_print_exit_value
setopt_if_exists rc_quotes
setopt_if_exists no_rm_star_silent
setopt_if_exists no_rm_star_wait
setopt_if_exists short_loops
setopt_if_exists short_repeat
setopt_if_exists no_sun_keyboard_hack

# "Job Control"

setopt_if_exists no_auto_continue
setopt_if_exists no_auto_resume
setopt_if_exists bg_nice
setopt_if_exists check_jobs
setopt_if_exists check_running_jobs
setopt_if_exists hup
setopt_if_exists notify

# "Prompting"

setopt_if_exists no_prompt_bang
setopt_if_exists prompt_cr
setopt_if_exists prompt_sp
setopt_if_exists prompt_percent
setopt_if_exists no_prompt_subst
setopt_if_exists no_transient_rprompt

# "Scripts and Functions"

setopt_if_exists no_alias_func_def
setopt_if_exists c_bases
setopt_if_exists c_precedences
setopt_if_exists no_debug_before_cmd
setopt_if_exists no_err_exit
setopt_if_exists no_err_return
setopt_if_exists no_multi_func_def
setopt_if_exists multios
setopt_if_exists no_octal_zeroes
setopt_if_exists pipe_fail
setopt_if_exists no_typeset_silent

# "Shell Emulation"

setopt_if_exists append_create
setopt_if_exists no_bsd_echo
setopt_if_exists no_continue_on_error
setopt_if_exists no_csh_junkie_loops
setopt_if_exists no_csh_junkie_quotes
setopt_if_exists no_csh_nullcmd
setopt_if_exists no_ksh_arrays
setopt_if_exists no_ksh_autoload
setopt_if_exists no_ksh_option_print
setopt_if_exists no_ksh_zero_subscript
setopt_if_exists posix_aliases
setopt_if_exists posix_builtins
setopt_if_exists posix_identifiers
setopt_if_exists no_posix_strings

# "Zle"

setopt_if_exists beep
setopt_if_exists combining_chars
setopt_if_exists no_emacs
setopt_if_exists vi
setopt_if_exists zle

unset setopt_if_exists
