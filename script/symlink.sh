#!/bin/bash

set -e

symlink() {
  local source_file=$1
  local destination_file=$2
  if [ -e $destination_file ]; then
    rm -r $destination_file
  fi
  ln -s $source_file $destination_file
}

scripts_directory="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
resources_directory="$scripts_directory/../resources"
for file in $(ls $resources_directory); do
  symlink "$resources_directory/$file" "$HOME/.$file"
done

mkdir -p $HOME/.ssh
symlink "$resources_directory/sshconfig" $HOME/.ssh/config

# make these history files nothing
symlink /dev/null $HOME/.lesshst
symlink /dev/null $HOME/.coffee_history
