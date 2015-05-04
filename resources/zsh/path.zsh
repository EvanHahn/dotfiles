prepend() {
  [ -d "$1" ] && PATH="$1:$PATH"
}

if hash getconf 2>/dev/null; then
  PATH="$(getconf PATH)"
fi

prepend '/usr/local/bin'

if hash brew 2>/dev/null; then
  prepend "$(brew --prefix coreutils)/libexec/gnubin"
fi

prepend "$HOME/.bin"

unset prepend

export PATH
