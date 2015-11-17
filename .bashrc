#                    /\ \__
#   ___ ___      __  \ \ ,_\  ____      __
#  /' __` __`\  /'__`\ \ \ \/ /\_ ,`\  /'__`\
#  /\ \/\ \/\ \/\ \L\.\_\ \ \_\/_/  /_/\  __/
#  \ \_\ \_\ \_\ \__/.\_\\ \__\ /\____\ \____\
#   \/_/\/_/\/_/\/__/\/_/ \/__/ \/____/\/____/
#

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

#{{{ Options
shopt -s autocd
shopt -s cdspell
shopt -s histappend
#}}}
#{{{ Binds
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'
#}}}
#{{{ Aliases
# Color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias la='ls -A'
alias ll='ls -l'
alias tmux="TERM=xterm-256color tmux"
alias waf='./waf'
alias mutt="TERM=xterm-256color mutt"
alias make="make -j4"
alias r="ranger"
alias docker="docker.io"
#}}}
#{{{ Functions
#{{{ Prompt
COLOR_NONE="\[\033[0m\]"
BROWN="\[\033[0;33m\]"
YELLOW="\[\033[1;33m\]"
LIGHT_GRAY="\[\033[0;37m\]"
DARK_GRAY="\[\033[1;30m\]"
HOST_COLOR="\[\033[1;$((31 + $(hostname | cksum | cut -c1-4) % 6))m\]"

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

        echo -n '\[\e[0;30m\]\[\e[0;'"$ansi"'m\]'"$branch"'\[\e[0m\] '
    fi
}

function _prompt_command() {
    if test -z "$VIRTUAL_ENV" ; then
        PYTHON_VIRTUALENV=""
    else
        PYTHON_VIRTUALENV="${YELLOW}* `basename \"$VIRTUAL_ENV\"`${COLOR_NONE} "
    fi

    _set_prompt_workingdir

    PS1="`_git_prompt`${PYTHON_VIRTUALENV}${DARK_GRAY}\u${COLOR_NONE}@${HOST_COLOR}\h${COLOR_NONE}:${BROWN}${NEW_PWD}${COLOR_NONE} "
}
#}}}
function man() {
    env LESS_TERMCAP_mb=$(printf "\e[1;31m") \
	LESS_TERMCAP_md=$(printf "\e[1;35m") \
	LESS_TERMCAP_me=$(printf "\e[0m") \
	LESS_TERMCAP_se=$(printf "\e[0m") \
	LESS_TERMCAP_so=$(printf "\e[1;33m") \
	LESS_TERMCAP_ue=$(printf "\e[0m") \
	LESS_TERMCAP_us=$(printf "\e[04;36m") \
	man "$@"
}

function _git_pick() {
    __gitcomp_nl "$(__git_refs)"
}
#}}}
#{{{ Completion
_cenv() {
    local cur=${COMP_WORDS[COMP_CWORD]}
    local envs=$(cenv --show | tr "\n" " ")
    COMPREPLY=($(compgen -W "${envs}" -- ${cur}))
}

_mx() {
    local cur=${COMP_WORDS[COMP_CWORD]}
    local sessions=$(tmux list-session | grep -o "^[A-Za-z0-9]*" | tr "\n" " ")
    COMPREPLY=($(compgen -W "${sessions}" -- ${cur}))
}

complete -F _cenv cenv
complete -F _mx mx
#}}}
#{{{ Environment
PROMPT_COMMAND=_prompt_command

HISTCONTROL=ignoredups:ignorespace
HISTSIZE=1000
HISTFILESIZE=2000
#}}}
#{{{ Sourcing
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

if [ -f ~/.bash_local ]; then
    . ~/.bash_local
fi

Z_SH="$(dirname $(readlink ~/.bashrc))/z/z.sh"

if [ -f $Z_SH ]; then
    . $Z_SH
fi

SOCK=/tmp/ssh-agent-tmux

if [ $SSH_AUTH_SOCK ] && [ $SSH_AUTH_SOCK != $SOCK ]; then
    rm -f $SOCK
    ln -s $SSH_AUTH_SOCK $SOCK
fi

export SSH_AUTH_SOCK=$SOCK
#}}}
