HERE := $(shell pwd)

all: links vim

links:
	ln -s -f $(HERE)/.bashrc ~/.bashrc
	ln -s -f $(HERE)/.gitconfig ~/.gitconfig
	ln -s -f $(HERE)/.tmux.conf ~/.tmux.conf
	ln -s -f $(HERE)/.vimrc ~/.vimrc

vim:
	python vim-setup.py
