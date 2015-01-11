my squiggle
===========

installation:

```sh
# clone this
git submodule update --init --recursive

cd script

./symlink.sh  # to symlink all files in `resources`

./osx-settings.sh  # OSX settings
./osx-packages.rb  # brew, brew-cask, and gem

./change-shell.sh  # to use ZSH (and add it to /etc/shells)
```

update:

```sh
vim +NeoBundleUpdate +qall

git submodule update --init --recursive
git submodule foreach git checkout master
git submodule foreach git pull
# git add any update submodules
```
