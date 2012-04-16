# Matze's .bashrc

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# --- general options ---------------------------------------------------------
set -o vi               # ;-)
shopt -s checkwinsize
shopt -s histappend

# --- bash history options ----------------------------------------------------
HISTCONTROL=ignoredups:ignorespace
HISTSIZE=1000
HISTFILESIZE=2000

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# --- aliases -----------------------------------------------------------------
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias tmux="TERM=xterm-256color tmux"

# --- bash completion ---------------------------------------------------------
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# --- misc environment variables (mostly fixes) -------------------------------
export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on"

# --- enhance prompt ----------------------------------------------------------
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
    local git_status="`git status -unormal 2>&1`"
    if ! [[ "$git_status" =~ Not\ a\ git\ repo ]]; then
        if [[ "$git_status" =~ nothing\ to\ commit ]]; then
            local ansi=42
        elif [[ "$git_status" =~ nothing\ added\ to\ commit\ but\ untracked\ files\ present ]]; then
            local ansi=43
        else
            local ansi=45
        fi
        if [[ "$git_status" =~ On\ branch\ ([^[:space:]]+) ]]; then
            branch=${BASH_REMATCH[1]}
            test "$branch" != master || branch=' '
        else
            # Detached HEAD.  (branch=HEAD is a faster alternative.)
            branch="(`git describe --all --contains --abbrev=4 HEAD 2> /dev/null ||
                echo HEAD`)"
        fi
        echo -n '\[\e[0;37;'"$ansi"';1m\]'"$branch"'\[\e[0m\] '
    fi
}

function _prompt_command() {
    PS1="`_git_prompt`"'\[\033[1;30m\]me\[\033[0m\]@\[\033[1;30m\]\h\[\033[0m\]:\[\033[0;33m\]$(_prompt_workingdir)\[\033[0m\]$ '
}

PROMPT_COMMAND=_prompt_command

if [ -f /usr/local/bin/fasd ]; then
    eval "$(fasd --init auto)"
    alias v='f -e vim'
    _fasd_bash_hook_cmd_complete v
fi

