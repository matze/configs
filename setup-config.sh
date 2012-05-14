#!/bin/sh

HERE=`pwd`

ln -s -f $HERE/.bashrc ~/.bashrc
ln -s -f $HERE/.gitconfig ~/.gitconfig
ln -s -f $HERE/.gitignore ~/.gitignore
ln -s -f $HERE/.goobookrc ~/.goobookrc
ln -s -f $HERE/.tmux.conf ~/.tmux.conf
ln -s -f $HERE/.vimrc ~/.vimrc

mkdir -p ~/.mutt/cache/bodies
mkdir -p ~/.mutt/cache/headers
mkdir -p ~/.mutt/temp

ln -s -f $HERE/.mutt/fzk.muttrc ~/.mutt/fzk.muttrc
ln -s -f $HERE/.mutt/gmail.muttrc ~/.mutt/gmail.muttrc
ln -s -f $HERE/.mutt/signature ~/.mutt/signature
ln -s -f $HERE/.mutt/aliases ~/.mutt/aliases

mkdir -p ~/.offlineimap
ln -s -f $HERE/offlineimap.py ~/.offlineimap/offlineimap.py
ln -s -f $HERE/.offlineimaprc ~/.offlineimaprc
