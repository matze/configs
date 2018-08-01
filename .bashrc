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
alias make="make -j4"
#}}}
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

function _prompt_command() {
    if test -z "$VIRTUAL_ENV" ; then
        PYTHON_VIRTUALENV=""
    else
        PYTHON_VIRTUALENV="${YELLOW}* `basename \"$VIRTUAL_ENV\"`${COLOR_NONE} "
    fi

    _set_prompt_workingdir

    echo -n "${PYTHON_VIRTUALENV}${DARK_GRAY}\u${COLOR_NONE}@${HOST_COLOR}\h${COLOR_NONE}:${BROWN}${NEW_PWD}${COLOR_NONE}"
}
#}}}
#{{{ man enhancement
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
#}}}
#{{{ ssh tmux integration
__tm_get_hostname() {
    local HOST="$(echo $* | rev | cut -d ' ' -f 1 | rev)"
    if echo $HOST | grep -P "^([0-9]+\.){3}[0-9]+" -q; then
        echo $HOST
    else
        echo $HOST | cut -d . -f 1
    fi
}

__tm_get_current_window() {
    tmux list-windows| awk -F : '/\(active\)$/{print $1}'
}

__tm_command() {
    if [ "$(ps -p $(ps -p $$ -o ppid=) -o comm=| cut -d : -f 1)" = "tmux" ]; then
        __tm_window=$(__tm_get_current_window)
        trap "tmux set-window-option -t $__tm_window automatic-rename on 1>/dev/null" RETURN
        tmux rename-window "$(__tm_get_hostname $*)"
    fi
    command "$@"
}

ssh() {
    __tm_command ssh "$@"
}
#}}}
#{{{ Completion
_git_pick() {
    __gitcomp_nl "$(__git_refs)"
}

_cenv() {
    local cur=${COMP_WORDS[COMP_CWORD]}
    local envs=$(cenv --show | tr "\n" " ")
    COMPREPLY=($(compgen -W "${envs}" -- ${cur}))
}

complete -F _cenv cenv
#}}}
#{{{ Environment
PROMPT_COMMAND='__git_ps1 "`_prompt_command`" " "'

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

if [ -f /usr/lib/git-core/git-sh-prompt ]; then
    . /usr/lib/git-core/git-sh-prompt
    export GIT_PS1_SHOWDIRTYSTATE=yes
    export GIT_PS1_SHOWCOLORHINTS=yes
    export GIT_PS1_SHOWSTASHSTATE=yes
    export GIT_PS1_SHOWUNTRACKEDFILES=yes
fi

command -v rg > /dev/null && export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git*"'

if [ -f ~/.fzf/key-bindings.bash ]; then
    . ~/.fzf/key-bindings.bash
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
