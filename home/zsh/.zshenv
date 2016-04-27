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

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

export LC_ALL='en_US.UTF-8'
export LANG='en_US.UTF-8'
export LANGUAGE='en_US.UTF-8'

export HISTFILE="$XDG_CACHE_HOME/zsh_history"
export HISTSIZE=10000
export SAVEHIST=9000

export CLICOLOR=1
export LS_COLORS='di=30;46:tw=30;46:ow=30;46:ex=31:su=31:sg=31:'
export LSCOLORS='afxxxxxxbxxxxxbxbxagag'

export GREP_OPTIONS='--color=auto'
export GREP_COLOR='00;36'

export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc"

export ZIPOPT='-9'

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

if hash less 2>/dev/null; then
  export LESS='--ignore-case --long-prompt --QUIET --raw-control-chars --no-init'
fi

export LYNX_CFG="$XDG_CONFIG_HOME/lynx/lynx.cfg"

export TIGRC_USER="$XDG_CONFIG_HOME/tig/tigrc"

export SCREENRC="$XDG_CONFIG_HOME/screen/screenrc"
