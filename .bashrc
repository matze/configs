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

function _prompt_workingdir () {
    local pwdmaxlen=$(($COLUMNS/5))
    local trunc_symbol="..."
    if [[ $PWD == $HOME* ]]; then
        newPWD="~${PWD#$HOME}" 
    else
        newPWD=${PWD}
    fi
    if [ ${#newPWD} -gt $pwdmaxlen ]; then
        local pwdoffset=$(( ${#newPWD} - $pwdmaxlen + 3 ))
        newPWD="${trunc_symbol}${newPWD:$pwdoffset:$pwdmaxlen}"
    fi
    echo $newPWD
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

function _colored_host() {
    echo "\[\033[1;$((31 + $(hostname | cksum | cut -c1-4) % 6))m\]\h\[\033[0m\]"
}

function _prompt_command() {
    PS1="`_git_prompt`"'\[\033[1;30m\]\u\[\033[0m\]@'"`_colored_host`"':\[\033[0;33m\]$(_prompt_workingdir)\[\033[0m\] '
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
