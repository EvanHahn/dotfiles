#!/usr/bin/env bash
set -e
set -u

port='8000'
if [ $# -eq 1 ]; then
  port="$1"
fi

if hash php 2>/dev/null; then
  php -S "localhost:$port"
elif hash ruby 2>/dev/null; then
  ruby -run -e httpd . -p "$port"
elif hash python 2>/dev/null; then
  # TODO: python 3 support
  # python -m http.server "$port"
  python -m SimpleHTTPServer "$port"
else
  echo 'unable to start HTTP server' 1>&2
  exit 1
fi
