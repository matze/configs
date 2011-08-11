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
export SISODIR5=/opt/siso
export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on"

# --- enhance prompt ----------------------------------------------------------
function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}

function parse_git_branch {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
}

function prompt_workingdir () {
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


gitbranch=$(parse_git_branch)

export PS1='\[\033[1;30m\]me\[\033[0m\]@\[\033[1;30m\]\h\[\033[0m\]:\[\033[0;33m\]$(prompt_workingdir)\[\033[0m\]$(parse_git_branch)$ '
#export PS1='\[$(bldblk)\]\u\[$(txtrst)\]@\h \[\033[1;33m\]\w\[\033[0m\]$(parse_git_branch)$ '
