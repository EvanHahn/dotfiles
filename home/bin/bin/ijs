#!/usr/bin/env bash
set -e
set -u
set -o pipefail

if hash deno 2>/dev/null; then
  exec deno repl
elif hash node 2>/dev/null; then
  exec node
elif hash osascript 2>/dev/null; then
  exec osascript -il JavaScript
else
  echo 'no js runtime found' 1>&2
  exit 1
fi
