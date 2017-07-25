if [[ "$(uname -s)" = 'Darwin' ]]; then
  z_path="$(brew --prefix)/etc/profile.d/z.sh"
else
  z_path='/usr/share/z/z.sh'
fi

if [[ -e "$z_path" ]]; then
  source "$z_path"
fi

unset z_path
