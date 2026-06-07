#!/usr/bin/env bash

input=$(cat)

export LC_NUMERIC=C

model=$(echo "$input" | jq -r '.model.display_name')
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
cost=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')
cost=$(printf '$%.2f' "$cost")
limit=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')

if [ -z "$used" ]; then
    exit 0
fi

bar_width=20

get_color() {
    local percentage=$1
    if [ "$percentage" -le 50 ]; then
        echo -n "\033[0;32m"
    elif [ "$percentage" -le 80 ]; then
        echo -n "\033[0;33m"
    else
        echo -n "\033[0;31m"
    fi
}

make_bar() {
    local percentage=$1
    local filled=$(( percentage * bar_width / 100 ))
    local empty=$(( bar_width - filled ))
    local bar=""
    for i in $(seq 1 "$filled"); do bar="${bar}━"; done
    for i in $(seq 1 "$empty"); do bar="${bar}─"; done
    echo -n "$bar"
}

reset="\033[0m"
used_int=$(printf '%.0f' "$used")
limit_int=$(printf '%.0f' "$limit")

used_color=$(get_color "$used_int")
used_bar=$(make_bar "$used_int")

limit_color=$(get_color "$limit_int")
limit_bar=$(make_bar "$limit_int")

printf "${model} • context ${used_color}${used_bar} ${used_int}%%${reset} • 5h limit ${limit_color}${limit_bar} ${limit_int}%%${reset} • ${cost}"
