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

used_int=$(printf '%.0f' "$used")
used_filled=$(( used_int * bar_width / 100 ))
used_empty=$(( bar_width - used_filled ))

used_bar=""
for i in $(seq 1 "$used_filled"); do used_bar="${used_bar}▒"; done
for i in $(seq 1 "$used_empty"); do used_bar="${used_bar}░"; done

limit_int=$(printf '%.0f' "$limit")
limit_filled=$(( limit_int * bar_width / 100 ))
limit_empty=$(( bar_width - limit_filled ))

limit_bar=""
for i in $(seq 1 "$limit_filled"); do limit_bar="${limit_bar}▒"; done
for i in $(seq 1 "$limit_empty"); do limit_bar="${limit_bar}░"; done

# Color: green <= 50%, yellow <= 80%, red > 80%
if [ "$used_int" -le 50 ]; then
    color="\033[0;32m"
elif [ "$used_int" -le 80 ]; then
    color="\033[0;33m"
else
    color="\033[0;31m"
fi
reset="\033[0m"

printf "${model} • context ${color}${used_bar} ${used_int}%%${reset} • 5h limit ${limit_bar} ${limit_int}%% • ${cost}"
