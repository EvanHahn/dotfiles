alias random="$DOTFILES_HOME/resources/bin/el-rando/el-rando.py"
alias is-github-up="$DOTFILES_HOME/resources/bin/is_github_up/is_github_up.rb"
alias iscp="$DOTFILES_HOME/resources/bin/iscp/iscp.sh"
alias journ="$DOTFILES_HOME/resources/bin/journ/journ"
alias rename="$DOTFILES_HOME/resources/bin/rename/rename.sh"

alias .='pwd'
alias ..='cd ..'
alias 2..='cd ../..'
alias 3..='cd ../../..'
alias 4..='cd ../../../..'
alias 5..='cd ../../../../..'

alias q='exit'

alias ed='ed -p:'
alias screen='screen -U'
alias tmux="tmux -u2 -f '$XDG_CONFIG_HOME/tmux/tmux.conf'"
if hash colordiff 2>/dev/null; then
  alias diff=colordiff
fi

alias mv='nocorrect mv -i -v'
alias cp='nocorrect cp -i -v'
alias mkdir='nocorrect mkdir -p -v'
alias ln='nocorrect ln -v'

alias please='sudo --set-home "$(fc -ln -1)"'

alias ,,='cd ..'
alias ..l='cd .. && ls'
alias :q='exit'
alias cd..='cd ..'
alias gits='git s'
alias gs='git s'
alias gut='git'
alias mdkir='mkdir'
alias npmi='npm i'
alias npmt='npm t'
alias sl='ls'
alias sudp='sudo'
alias snippet='snippets'

tempe () {
  cd "$(mktemp -d)"
  if [[ $# -eq 1 ]]; then
    \mkdir -p "$1"
    cd "$1"
  fi
}

chase () {
  local last_command
  local command_name
  local subcommand
  local last_arg
  local git_folder

  last_command="$(fc -ln -1)"
  command_name="$(echo "$last_command" | awk '{print $1}')"
  last_arg="$(echo "$last_command" | awk '{print $(NF)}')"

  case "$command_name" in
    mv|cp|mkdir|open)
      if [[ -d "$last_arg" ]]; then
        cd "$last_arg"
      elif [[ -d "$(dirname "$last_arg")" ]]; then
        cd "$(dirname "$last_arg")"
      fi
      ;;
    g|git)
      subcommand="$(echo "$last_command" | awk '{print $2}')"
      if [[ "$subcommand" == 'clone' ]]; then
        if [[ -d "$last_arg" ]]; then
          git_folder="$last_arg"
        else
          git_folder="$(echo "$last_arg" | grep -oE '[^/]+$' | sed 's/\.[^.]*$//g')"
        fi
        cd "$git_folder"
      else
        echo "cannot chase $command_name $subcommand" >&2
        false
      fi
      ;;
    *)
      echo "cannot chase $command_name" >&2
      false
  esac
}
