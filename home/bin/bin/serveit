#!/usr/bin/env bash
set -e
set -u
set -o pipefail

port='8000'
if [ $# -eq 1 ]; then
  port="$1"
fi

if hash php 2>/dev/null; then
  exec php -S "localhost:$port"
elif hash python3 2>/dev/null; then
  exec python3 -m http.server "$port"
elif hash python 2>/dev/null; then
  major_version="$(python -c 'import platform as p;print(p.python_version_tuple()[0])')"
  if [[ "$major_version" == '3' ]]; then
    exec python -m http.server "$port"
  else
    exec python -m SimpleHTTPServer "$port"
  fi
elif hash ruby 2>/dev/null; then
  exec ruby -run -e httpd . -p "$port"
else
  echo 'unable to start HTTP server' 1>&2
  exit 1
fi
