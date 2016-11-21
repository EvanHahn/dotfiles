#!/usr/bin/env bash
set -e
set -u
set -o pipefail

ufw='/usr/sbin/ufw'

if [ ! -f "$ufw" ]; then
  >&2 echo "ufw not found at $ufw"
  >&2 echo 'please install it with "sudo apt-get install ufw" and try again'
  exit 1
fi

sudo "$ufw" reset
sudo "$ufw" default deny incoming
sudo "$ufw" default deny incoming
sudo "$ufw" enable
sudo systemctl enable ufw
