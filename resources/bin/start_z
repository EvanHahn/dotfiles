#!/usr/bin/env bash
set -eu

z_path='/a/bogus/path'

if [[ "$(uname -s)" = 'Darwin' ]]; then
  z_path="$(brew --prefix)/etc/profile.d/z.sh"
fi

if [[ -e "$z_path" ]]; then
  set +eu
  source "$z_path"
fi
