# "global" system stuff

export LC_ALL='en_US.UTF-8'
export LANG='en_US.UTF-8'
export LANGUAGE='en_US.UTF-8'

if hash getconf 2>/dev/null; then
  PATH="$(getconf PATH)"
fi
prepend() {
  [ -d "$1" ] && PATH="$1:$PATH"
}
prepend '/usr/local/bin'
prepend "$HOME/bin"
unset prepend
export PATH

if hash nvim 2>/dev/null; then
  export EDITOR=nvim
elif hash vim 2>/dev/null; then
  export EDITOR=vim
else
  export EDITOR=vi
fi
export USE_EDITOR="$EDITOR"
export VISUAL="$EDITOR"

if hash vimpager 2>/dev/null; then
  export PAGER=vimpager
elif hash most 2>/dev/null; then
  export PAGER=most
elif hash less 2>/dev/null; then
  export PAGER=less
elif hash more 2>/dev/null; then
  export PAGER=more
else
  export PAGER=cat
fi

zshenv_path="${(%):-%N}"
zsh_dotfiles_path="$(dirname "$(readlink "$zshenv_path")")"
export DOTFILES_HOME="$zsh_dotfiles_path"
unset zshenv_path
unset zsh_dotfiles_path

# zsh stuff

export HISTFILE="$XDG_CACHE_HOME/zsh_history"
export HISTSIZE=10000
export SAVEHIST=9000

export CLICOLOR=1

# commands

export ATOM_HOME="$XDG_CONFIG_HOME/atom"

export bower_storage__packages="$XDG_CACHE_HOME/bower/packages"
export bower_storage__registry="$XDG_CACHE_HOME/bower/registry"
export bower_storage__links="$XDG_CACHE_HOME/bower/links"
export bower_tmp="$XDG_CACHE_HOME/bower/tmp"

export GREP_COLOR='00;36'

export HOMEBREW_NO_EMOJI=1
export HOMEBREW_NO_GITHUB_API=1
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_INSECURE_REDIRECT=1

export LESS='--ignore-case --long-prompt --QUIET --raw-control-chars --no-init'
export LESSHISTFILE="$XDG_CACHE_HOME/lesshst"
export LESSSECURE=1

export LS_COLORS='di=30;46:tw=30;46:ow=30;46:ex=31:su=31:sg=31:'
export LSCOLORS='afxxxxxxbxxxxxbxbxagag'

export LYNX_CFG="$XDG_CONFIG_HOME/lynx/lynx.cfg"

export NODE_REPL_HISTORY="$XDG_CACHE_HOME/node_repl_history"
export NPM_CONFIG_EDITOR="$EDITOR"
export NPM_CONFIG_INIT_AUTHOR_NAME='Evan Hahn'
export NPM_CONFIG_INIT_AUTHOR_EMAIL='me@evanhahn.com'
export NPM_CONFIG_INIT_AUTHOR_URL='https://evanhahn.com'
export NPM_CONFIG_INIT_LICENSE='MIT'
export NPM_CONFIG_INIT_VERSION='0.0.0'
export NPM_CONFIG_PROGRESS='true'
export NPM_CONFIG_SAVE='true'
export NPM_CONFIG_CACHE_MIN='120'

export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc"

export SCREENRC="$XDG_CONFIG_HOME/screen/screenrc"

export SNIPPETS_FOLDER="$XDG_CONFIG_HOME/snippets"

export TIGRC_USER="$XDG_CONFIG_HOME/tig/tigrc"

export TIMEFMT=$'\n\e[33m%J\e[0m took \e[35m%E\e[0m'

export VAGRANT_CHECKPOINT_DISABLE='yes'

export VIMPAGER_RC="$XDG_CONFIG_HOME/vimpager/vimpagerrc"

export WWW_HOME='https://duckduckgo.com'

export _Z_DATA="$XDG_CACHE_HOME/z-cache"

export ZIPOPT='-9'
