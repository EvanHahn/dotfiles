#!/bin/bash

# nvm adds a "start nvm" thing to a variable called $PROFILE.
# we don't want that so redirect to /dev/null
export PROFILE=/dev/null
(curl -sSL https://raw.githubusercontent.com/creationix/nvm/v0.7.0/install.sh | sh) > /dev/null
unset PROFILE

# start nvm
source $HOME/.nvm/nvm.sh

# install the latest 0.10
NODE_VERSION_TO_INSTALL=`nvm ls-remote | grep "v0\.10\." | tail -n 1`

# install and default that
nvm install $NODE_VERSION_TO_INSTALL
nvm alias default $NODE_VERSION_TO_INSTALL
