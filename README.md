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


./osx.sh # if on OSX
./debian.sh # if on Ubuntu/Debian
vim +NeoBundleInstall +qall
```

update:

```sh
vim +NeoBundleUpdate +qall

git submodule foreach git pull
# git add any update submodules
```
