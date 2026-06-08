#                    /\ \__
#   ___ ___      __  \ \ ,_\  ____      __
#  /' __` __`\  /'__`\ \ \ \/ /\_ ,`\  /'__`\
#  /\ \/\ \/\ \/\ \L\.\_\ \ \_\/_/  /_/\  __/
#  \ \_\ \_\ \_\ \__/.\_\\ \__\ /\____\ \____\
#   \/_/\/_/\/_/\/__/\/_/ \/__/ \/____/\/____/
#

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

#{{{ options
shopt -s autocd
shopt -s cdspell
shopt -s histappend

HISTCONTROL=ignoredups:ignorespace
HISTSIZE=1000
HISTFILESIZE=2000
#}}}
#{{{ key binds
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'
#}}}
#{{{ aliases
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
#}}}
#{{{ functions
function man-browse() {
    man -k . | fzf | man $(sed -n 's/^\(.*\) (\([0-9]\)).*$/\2 \1/p')
}
#}}}
#{{{ prompt (pure-style, jj-aware)
# A two-line prompt inspired by sindresorhus/pure. Colocated jj repos take
# precedence over git. Everything is synchronous but kept to a single VCS
# subprocess per prompt, so it stays fast.

_PROMPT_SYMBOL="❯"

# Colours, wrapped in \[ \] so bash can compute the prompt width correctly.
_C_RESET="\[\e[0m\]"
_C_PATH="\[\e[34m\]"       # blue   - working directory
_C_VCS="\[\e[38;5;242m\]" # grey   - branch / change id + dirty marker
_C_ARROW="\[\e[36m\]"     # cyan   - ahead/behind arrows
_C_HOST="\[\e[38;5;242m\]" # grey  - user@host (ssh only)
_C_VENV="\[\e[38;5;242m\]" # grey  - virtualenv name
_C_OK="\[\e[35m\]"        # magenta - prompt symbol, last command succeeded
_C_ERR="\[\e[31m\]"       # red     - prompt symbol, last command failed

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

# jj: show change id, bookmarks and a dirty marker. --ignore-working-copy keeps
# it fast and avoids spamming the operation log on every prompt; the dirty state
# therefore reflects the last snapshot, which is refreshed by any jj command.
function _jj_info() {
    local info
    info=$(jj log --no-graph --ignore-working-copy --color=never -r @ \
        -T 'separate(" ", change_id.shortest(8), bookmarks, if(empty, "", "*"), if(conflict, "×"))' \
        2>/dev/null) || return
    [ -n "$info" ] && printf '%s' "${_C_VCS}${info}${_C_RESET}"
}

# git: branch (or short sha when detached), a dirty marker and ahead/behind
# arrows, all from a single `git status` call.
function _git_info() {
    local line head oid ab ahead behind dirty arrows
    while IFS= read -r line; do
        case "$line" in
            "# branch.head "*) head="${line#\# branch.head }" ;;
            "# branch.oid "*)  oid="${line#\# branch.oid }" ;;
            "# branch.ab "*)
                ab="${line#\# branch.ab }"
                ahead="${ab%% *}"; ahead="${ahead#+}"
                behind="${ab##* }"; behind="${behind#-}"
                ;;
            "#"*) ;;
            *) dirty="*" ;;
        esac
    done < <(git status --porcelain=v2 --branch 2>/dev/null)

    [ -z "$head" ] && return
    [ "$head" = "(detached)" ] && head="${oid:0:7}"

    [ "${ahead:-0}" -gt 0 ] 2>/dev/null && arrows="${arrows}⇡"
    [ "${behind:-0}" -gt 0 ] 2>/dev/null && arrows="${arrows}⇣"

    printf '%s' "${_C_VCS}${head}${dirty}${_C_RESET}"
    [ -n "$arrows" ] && printf '%s' " ${_C_ARROW}${arrows}${_C_RESET}"
}

# Walk up the tree to find the closest repo, preferring a colocated jj repo.
function _vcs_info() {
    local dir="$PWD"
    while : ; do
        if [ -d "$dir/.jj" ]; then
            command -v jj >/dev/null 2>&1 && { _jj_info; return; }
        fi
        [ -e "$dir/.git" ] && { _git_info; return; }
        [ "$dir" = "/" ] || [ -z "$dir" ] && break
        dir="${dir%/*}"
    done
}

function _prompt_command() {
    local exit=$?
    local venv="" host="" sym vcs

    [ -n "$VIRTUAL_ENV" ] && venv="${_C_VENV}${VIRTUAL_ENV##*/}${_C_RESET} "

    _set_prompt_workingdir

    vcs=$(_vcs_info)
    [ -n "$vcs" ] && vcs=" ${vcs}"

    [ -n "$SSH_CONNECTION" ] && host=" ${_C_HOST}\u@\h${_C_RESET}"

    if [ "$exit" -eq 0 ]; then sym="$_C_OK"; else sym="$_C_ERR"; fi

    PS1="${venv}${_C_PATH}${NEW_PWD}${_C_RESET}${vcs}${host} ${sym}${_PROMPT_SYMBOL}${_C_RESET} "
}

PROMPT_COMMAND=_prompt_command
#}}}
#{{{ man enhancement
export LESS_TERMCAP_mb=$(printf "\e[1;31m")
export LESS_TERMCAP_md=$(printf "\e[1;35m")
export LESS_TERMCAP_me=$(printf "\e[0m")
export LESS_TERMCAP_se=$(printf "\e[0m")
export LESS_TERMCAP_so=$(printf "\e[1;33m")
export LESS_TERMCAP_ue=$(printf "\e[0m")
export LESS_TERMCAP_us=$(printf "\e[04;36m")
#}}}
#{{{ ssh + tmux integration
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

SOCK=/tmp/ssh-agent-tmux

if [ $SSH_AUTH_SOCK ] && [ $SSH_AUTH_SOCK != $SOCK ]; then
    rm -f $SOCK
    ln -s $SSH_AUTH_SOCK $SOCK
fi

export SSH_AUTH_SOCK=$SOCK
#}}}
#{{{ fzf + fd
export FZF_DEFAULT_COMMAND='fd --type file --hidden --exclude .git --color=always'
export FZF_DEFAULT_OPTS="--ansi"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

bind -x '"\C-p": vi $(fzf);'
#}}}
#{{{ bash completion
_git_pick() {
    __gitcomp_nl "$(__git_refs)"
}

_cenv() {
    local cur=${COMP_WORDS[COMP_CWORD]}
    local envs=$(cenv --show | tr "\n" " ")
    COMPREPLY=($(compgen -W "${envs}" -- ${cur}))
}

complete -F _cenv cenv

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi
#}}}
#{{{ local bash
if [ -f ~/.bash_local ]; then
    . ~/.bash_local
fi
#}}}
