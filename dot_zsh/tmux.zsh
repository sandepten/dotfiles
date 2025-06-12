# primaegen fzf projects

_fzf_tmux_switcher() {
    local selected
    local selected_name
    local tmux_running

    if [[ $# -eq 1 ]]; then
        selected=$1
    else
        selected=$(find ~/code ~/code/dsa ~/ ~/code/projects/jio ~/code/projects/personel -mindepth 1 -maxdepth 1 -type d | fzf)
    fi

    if [[ -z $selected ]]; then
        return 0
    fi

    selected_name=$(basename "$selected" | tr . _)
    tmux_running=$(pgrep tmux)

    if [[ -z "$TMUX" ]] && [[ -z "$tmux_running" ]]; then
        tmux new-session -s "$selected_name" -c "$selected"
        return 0
    fi

    if ! tmux has-session -t="$selected_name" 2>/dev/null; then
        tmux new-session -ds "$selected_name" -c "$selected"
    fi

    tmux switch-client -t "$selected_name"
}

# Declare the function as a ZLE widget
zle -N _fzf_tmux_switcher

# Bind the widget to Ctrl+P
bindkey '^P' _fzf_tmux_switcher
