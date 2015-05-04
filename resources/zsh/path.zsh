prepend() {
  [ -d "$1" ] && PATH="$1:$PATH"
}

if hash getconf 2>/dev/null; then
  PATH="$(getconf PATH)"
fi

prepend '/usr/local/bin'
prepend "$HOME/.bin"

unset prepend

export PATH
