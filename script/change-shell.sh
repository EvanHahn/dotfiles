#!/usr/bin/env bash
set -e
set -u

if hash zsh 2>/dev/null; then
  shellpath="$(which zsh)"
elif hash bash 2>/dev/null; then
  shellpath="$(which bash)"
else
  exit 0
fi

is_allowed="$(grep $shellpath /etc/shells | wc -l | awk '{print $1}')"
if [ "$is_allowed" == '0' ]; then
  echo "$shellpath is not in /etc/shells. i'm gonna need sudo..."
  echo "$shellpath" > /tmp/add_to_etc_shells
  sudo tee -a /etc/shells < /tmp/add_to_etc_shells
  rm /tmp/add_to_etc_shells
fi

chsh -s "$shellpath"
sudo chsh -s "$shellpath"
