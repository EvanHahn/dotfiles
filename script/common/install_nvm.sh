#!/bin/bash

# nvm adds a "start nvm" thing to a variable called $PROFILE.
# we don't want that so redirect to /dev/null
curl -sSL https://raw.githubusercontent.com/creationix/nvm/v0.7.0/install.sh | PROFILE=/dev/null sh

# start nvm
source $HOME/.nvm/nvm.sh

# 0.10 please
nvm install 0.10
nvm unalias default > /dev/null # unalias just in case
nvm alias default 0.10
