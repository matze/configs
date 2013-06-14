# If not running interactively, don't do anything
[ -z "$PS1" ] && return


# --- general options ----------------------------
shopt -s histappend
shopt -s cdspell
set -o vi


# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi


# --- aliases ------------------------------------

alias ll='ls -alF'
alias la='ls -A'
alias tmux="TERM=xterm-256color tmux"
alias waf='./waf'


# --- binds --------------------------------------

bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'


# --- enhance prompt -----------------------------
COLOR_NONE="\[\033[0m\]"
BROWN="\[\033[0;33m\]"
CYAN="\[\033[0;36m\]"
YELLOW="\[\033[1;33m\]"
LIGHT_GRAY="\[\033[0;37m\]"
DARK_GRAY="\[\033[1;30m\]"

function _set_prompt_workingdir () {
    local pwdmaxlen=$(($COLUMNS/5))
    local trunc_symbol="..."
    if [[ $PWD == $HOME* ]]; then
        NEW_PWD="~${PWD#$HOME}"
    else
        NEW_PWD=${PWD}
    fi
    if [ ${#NEW_PWD} -gt $pwdmaxlen ]; then
        local pwdoffset=$(( ${#NEW_PWD} - $pwdmaxlen + 3 ))
        NEW_PWD="${trunc_symbol}${NEW_PWD:$pwdoffset:$pwdmaxlen}"
    fi
}

function _git_prompt() {
    local git_status="`git status --porcelain 2>&1`"
    if ! [[ "$git_status" =~ Not\ a\ git\ repo ]]; then
        if [ -z "$git_status" ]; then
            local ansi=42
        elif [[ "$git_status" == *" M "* ]]; then
            local ansi=45
        else
            local ansi=43
        fi

        local branch=$(__git_ps1 "%s")
        test "$branch" != master || branch=' '

        echo -n '\[\e[0;37;'"$ansi"';1m\]'"$branch"'\[\e[0m\] '
    fi
}

function _set_host_color() {
    HOST_COLOR="\[\033[1;$((31 + $(hostname | cksum | cut -c1-4) % 6))m\]"
}

function _prompt_command() {

    if test -z "$VIRTUAL_ENV" ; then
        PYTHON_VIRTUALENV=""
    else
        PYTHON_VIRTUALENV="${YELLOW}☼ `basename \"$VIRTUAL_ENV\"`${COLOR_NONE} "
    fi

    _set_host_color
    _set_prompt_workingdir

    PS1="`_git_prompt`${PYTHON_VIRTUALENV}${DARK_GRAY}\u${COLOR_NONE}@${HOST_COLOR}\h${COLOR_NONE}:${BROWN}${NEW_PWD}${COLOR_NONE} "
}


# --- environment variables ----------------------

EDITOR=$(which vi)
VISUAL=$EDITOR
GIT_EDITOR=$EDITOR

PATH=$PATH:$HOME/.local/bin
PROMPT_COMMAND=_prompt_command

HISTCONTROL=ignoredups:ignorespace
HISTSIZE=1000
HISTFILESIZE=2000

RI="-Tf ansi"


# --- source other things ------------------------

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

if [ -f ~/.bash_local ]; then
    . ~/.bash_local
fi

if [ -f ~/.z.sh ]; then
    . ~/.z.sh
fi
