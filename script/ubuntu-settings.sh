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

set +e
which ubuntu-drivers
if [ $? != 0 ]; then
  >&2 echo 'ubuntu-drivers not found'
  >&2 echo 'please install it with "sudo apt-get install ubuntu-drivers-common" and try again'
fi
set -e

sudo "$ufw" reset
sudo "$ufw" default deny incoming
sudo "$ufw" default deny incoming
sudo "$ufw" enable
sudo systemctl enable ufw

sudo ubuntu-drivers autoinstall
