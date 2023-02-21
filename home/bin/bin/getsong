#!/usr/bin/env bash
set -e
set -u
set -o pipefail

exec yt-dlp -f bestaudio -o '%(title)s.%(ext)s' "$@"
