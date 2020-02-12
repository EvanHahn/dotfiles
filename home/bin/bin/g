#!/usr/bin/env bash
set -e
set -u

if [ $# -eq 0 ]; then
  exec git status
else
  exec git "$@"
fi
