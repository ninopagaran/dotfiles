#!/usr/bin/env bash

selected=$(cat "$HOME/.config/tmux/.tmux-cht-languages" "$HOME/.config/tmux/.tmux-cht-command" | fzf)
if [[ -z $selected ]]; then
    exit 0
fi

read -p "Enter Query: " query

if grep -qs "$selected" "$HOME/.config/tmux/.tmux-cht-languages"; then
    query=$(echo "$query" | tr ' ' '+')
    if [[ -z $query ]]; then
        tmux neww bash -c "echo \"# curl cht.sh/$selected\"; curl -s cht.sh/$selected | less -R"
    else
        tmux neww bash -c "echo \"# curl cht.sh/$selected/$query\"; curl -s cht.sh/$selected/$query | less -R"
        # tmux neww bash -c "echo \"# curl cht.sh/$selected/$query/?style=none\"; curl cht.sh/$selected/$query/?style=none | less -R"
    fi
else
    tmux neww bash -c "echo \"# curl cht.sh/$selected~$query\"; curl -s cht.sh/$selected~$query | less -R"
fi

