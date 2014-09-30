#!/usr/bin/env bash
set -e

echo -en '\033[35m'
echo "~~** hey it's me, interactive scp **~~"
echo -en '\033[0m'

direction='not yet specified'
while [ "$direction" != 'from' ] && [ "$direction" != 'to' ]; do
  echo -n 'Are you copying FROM or TO a remote server? '
  read temp
  direction="$(echo $temp | awk '{print tolower($0)}')"
done
