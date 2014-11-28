my squiggle
===========

installation:

```sh
# clone this
git submodule update --init --recursive

cd script

./symlink.sh  # to symlink all files in resources
./use_zsh.sh  # to use ZSH
./osx.sh      # to set up OSX preferences
./atom_packages.sh  # to install Atom packages

vim +NeoBundleInstall +qall
```

update:

```sh
vim +NeoBundleUpdate +qall

git submodule update --init --recursive
git submodule foreach git checkout master
git submodule foreach git pull
# git add any update submodules
```
