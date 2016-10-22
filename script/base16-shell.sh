#!/usr/bin/env bash
set -e
set -u
set -o pipefail

git clone 'https://github.com/chriskempson/base16-shell.git' "$XDG_CONFIG_HOME/base16-shell"
