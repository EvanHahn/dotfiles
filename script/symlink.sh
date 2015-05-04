#!/usr/bin/env bash
set -e
set -u

symlink() {
  local source_file="$1"
  local destination_file="$2"

  set +e
  rm -r "$destination_file" 2> /dev/null
  set -e

  ln -s "$source_file" "$destination_file"
}

mkdir -p "$HOME/.config"

scripts_directory="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
resources_directory="$scripts_directory/../resources"
for file in $(ls $resources_directory); do
  if [ "$file" == "config" ]; then
    for configfile in $(ls "$resources_directory/config"); do
      symlink "$resources_directory/config/$configfile" "$HOME/.config/$configfile"
    done
  else
    symlink "$resources_directory/$file" "$HOME/.$file"
  fi
done

# make these history files nothing
symlink /dev/null "$HOME/.lesshst"
symlink /dev/null "$HOME/.coffee_history"
