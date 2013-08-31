#!/bin/bash

HERE=`pwd`
NEOBUNDLE_URL="https://github.com/Shougo/neobundle.vim"
NEOBUNDLE_DIR="$HOME/.vim/bundle/neobundle.vim"

# Create necessary directories
mkdir -p ~/.vim/{after/ftplugin,autoload,bundle,colors,ftdetect}
mkdir -p ~/.config

# Setup symlinks
ln -s -f $HERE/.bashrc ~/.bashrc
ln -s -f $HERE/.gitconfig ~/.gitconfig
ln -s -f $HERE/.tmux.conf ~/.tmux.conf
ln -s -f $HERE/.vimrc ~/.vimrc
ln -s -f $HERE/.vimperatorrc ~/.vimperatorrc
ln -s -f $HERE/z/z.sh ~/.z.sh

for source in `find vim/ -type f`; do
    ln -s -f $PWD/$source ~/.$source
done

# Checkout Vundle
if [ ! -d "$NEOBUNDLE_DIR" ]; then
    git clone $NEOBUNDLE_URL $NEOBUNDLE_DIR
fi

# Get submodule if not existing
if [ ! -f $PWD/z/z.sh ]; then
    git submodule init
    git submodule update
fi
