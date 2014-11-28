#!/usr/bin/env bash
set -e
set -u

if [ $# -eq 0 ]; then
  echo "usage: rename [file1, file2, file3...]" 1>&2
  exit 1
fi

for filename in "$@"; do
  if [ ! -e "$filename" ]; then
    echo "$filename does not exist"
    exit 1
  fi
  read -e -i "$filename" -p "Rename $filename to: " destination
  mv "$filename" "$destination"
done
