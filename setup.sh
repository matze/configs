#!/bin/bash

HERE=`pwd`
VUNDLE_URL="https://github.com/gmarik/vundle.git"
VUNDLE_DIR="$HOME/.vim/bundle/vundle"

AUTOJUMP_URL="https://github.com/joelthelion/autojump.git"
AUTOJUMP_DIR="$HOME/.autojump"

# Create necessary directories
mkdir -p ~/.vim/{after/ftplugin,autoload,bundle,colors,ftdetect}
mkdir -p ~/.config

# Setup symlinks
ln -s -f $HERE/.bashrc ~/.bashrc
ln -s -f $HERE/.gitconfig ~/.gitconfig
ln -s -f $HERE/.tmux.conf ~/.tmux.conf
ln -s -f $HERE/.Xdefaults ~/.Xdefaults
ln -s -f $HERE/.vimrc ~/.vimrc
ln -s -f $HERE/ranger ~/.config/ranger
ln -s -f $HERE/z/z.sh ~/.z.sh

for source in `find vim/ -type f`; do
    ln -s -f $PWD/$source ~/.$source
done

# Checkout Vundle
if [ ! -d "$VUNDLE_DIR" ]; then
    git clone $VUNDLE_URL $VUNDLE_DIR
fi
