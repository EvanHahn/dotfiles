#!/usr/bin/env bash
set -e
set -u

if test -t 1; then
  exec 1>/dev/null
fi

if test -t 2; then
  exec 2>/dev/null
fi

"$@" &
