my squiggle
===========

installation:

```bash
# clone this puppy
git submodule init
git submodule update

cd script
./symlink.sh
touch $HOME/.tmux_local.conf

vim +NeoBundleInstall +qall
./osx.sh # if on OSX
./debian.sh # if on Ubuntu/Debian/whatever

./npm.sh # if you want packages from NPM
```

wow
