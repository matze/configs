#!/bin/sh

HERE=`pwd`
VUNDLE_URL="https://github.com/gmarik/vundle.git"

# Create necessary directories
mkdir -p ~/.vim ~/.vim/autoload ~/.vim/bundle ~/.vim/colors

# Setup symlinks
ln -s -f $HERE/.bashrc ~/.bashrc
ln -s -f $HERE/.gitconfig ~/.gitconfig
ln -s -f $HERE/.gitignore ~/.gitignore
ln -s -f $HERE/.tmux.conf ~/.tmux.conf
ln -s -f $HERE/.Xdefaults ~/.Xdefaults
ln -s -f $HERE/.vimrc ~/.vimrc
ln -s -f $HERE/lilypink.vim ~/.vim/colors/lilypink.vim

# Checkout Vundle
git clone $VUNDLE_URL  ~/.vim/bundle/vundle
