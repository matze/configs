HERE := $(shell pwd)

all: config vim

vim:
	python vim-setup.py

config:
	sh setup-config.sh
