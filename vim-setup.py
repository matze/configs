#!/usr/bin/env python
"""vim-setup.py: Re-create .vim directory and update plugins"""

import os, urllib, subprocess

PATHOGEN_URL = 'https://raw.github.com/tpope/vim-pathogen/HEAD/autoload/pathogen.vim'

GITHUB_REPOS = [
    "mileszs/ack.vim",
    "Raimondi/delimitMate",
    "Shougo/neocomplcache",
    "Shougo/neocomplcache-snippets-complete",
    "Lokaltog/vim-powerline",
    "kien/ctrlp.vim",
    "tpope/vim-commentary",
    "tpope/vim-markdown",
    "tpope/vim-fugitive",
    "nvie/vim-flake8",
    "xolox/vim-notes",
    "vim-scripts/LustyJuggler"
    ]

COLOR_SCHEMES = [ 'https://raw.github.com/vim-scripts/lilypink/master/colors/lilypink.vim' ]


def partial_path(repo):
    return repo.split('/')[-1]

def do_git(command):
    p = subprocess.Popen('git %s' % command, shell=True)
    os.waitpid(p.pid, 0)

def curl_get(url):
    print "GET %s" % url
    return urllib.urlopen(url).read()

if __name__ == '__main__':
    vimdir = os.path.expanduser('~/.vim')
    bundledir = vimdir + '/bundle'

    if not os.path.exists(vimdir):
        print "mkdir ~/.vim, ~/.vim/autoload, ~/.vim/bundle ..."
        os.mkdir(vimdir)
        os.mkdir(vimdir + '/autoload')
        os.mkdir(bundledir)

    pathogen_path = vimdir + '/autoload/pathogen.vim'
    if not os.path.exists(pathogen_path):
        open(pathogen_path, 'w').write(curl_get(PATHOGEN_URL))

    for repo in GITHUB_REPOS:
        repo_path = bundledir + '/' + partial_path(repo)
        if os.path.exists(repo_path):
            print 'Updating %s' % repo
            os.chdir(repo_path)
            do_git('pull')
        else:
            print 'Cloning %s' % repo
            os.chdir(bundledir)
            do_git('clone https://github.com/%s.git' % repo)

    colors_path = vimdir + '/colors'
    if not os.path.exists(colors_path):
        print "mkdir ~/.vim/colors"
        os.mkdir(colors_path)

    for scheme_url in COLOR_SCHEMES:
        filename = colors_path + '/' + partial_path(scheme_url)
        open(filename, 'w').write(curl_get(scheme_url))

