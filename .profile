export EDITOR=$(which vim)
export VISUAL=$EDITOR
export GIT_EDITOR=$EDITOR
export PATH=$HOME/.local/bin:$HOME/.cabal/bin:/usr/local/go/bin:$PATH

export GOROOT=$HOME/.local/go
export GOPATH=$HOME/dev/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

source ~/.bashrc
