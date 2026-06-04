#!/usr/bin/env bash

input=$(cat)

export LC_NUMERIC=C

model=$(echo "$input" | jq -r '.model.display_name')
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
cost=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')
cost=$(printf '$%.2f' "$cost")

if [ -z "$used" ]; then
    exit 0
fi

used_int=$(printf '%.0f' "$used")
bar_width=30
filled=$(( used_int * bar_width / 100 ))
empty=$(( bar_width - filled ))

bar=""
for i in $(seq 1 "$filled"); do bar="${bar}▒"; done
for i in $(seq 1 "$empty"); do bar="${bar}░"; done

# Color: green <= 50%, yellow <= 80%, red > 80%
if [ "$used_int" -le 50 ]; then
    color="\033[0;32m"
elif [ "$used_int" -le 80 ]; then
    color="\033[0;33m"
else
    color="\033[0;31m"
fi
reset="\033[0m"

printf "${model} ${color}${bar} ${used_int}%%${reset} • ${cost}"
