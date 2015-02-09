#!/usr/bin/env bash
set -e
set -u

symlink() {
  local source_file="$1"
  local destination_file="$2"
  if [ -e "$destination_file" ]; then
    rm -r "$destination_file"
  fi
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
