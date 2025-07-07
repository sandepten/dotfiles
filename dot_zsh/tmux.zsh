# primaegen fzf projects

# _fzf_tmux_switcher() {
#     local selected
#     local selected_name
#     local tmux_running
#
#     if [[ $# -eq 1 ]]; then
#         selected=$1
#     else
#         selected=$(find ~/code ~/code/dsa ~/ ~/code/projects/jio ~/code/projects/personel ~/Documents -mindepth 1 -maxdepth 1 -type d | fzf)
#     fi
#
#     if [[ -z $selected ]]; then
#         return 0
#     fi
#
#     selected_name=$(basename "$selected" | tr . _)
#     tmux_running=$(pgrep tmux)
#
#     if [[ -z "$TMUX" ]] && [[ -z "$tmux_running" ]]; then
#         tmux new-session -s "$selected_name" -c "$selected"
#         return 0
#     fi
#
#     if ! tmux has-session -t="$selected_name" 2>/dev/null; then
#         tmux new-session -ds "$selected_name" -c "$selected"
#     fi
#
#     if [[ -z $TMUX ]]; then
#         tmux attach -t $selected_name
#     else
#         tmux switch-client -t $selected_name
#     fi
# }
#
# # Declare the function as a ZLE widget
# zle -N _fzf_tmux_switcher

# Bind the widget to Ctrl+P
# bindkey '^P' _fzf_tmux_switcher
bindkey -s ^p "tmux-sessionizer\n"
bindkey -s '\eh' "tmux-sessionizer -s 0\n"
bindkey -s '\et' "tmux-sessionizer -s 1\n"
bindkey -s '\en' "tmux-sessionizer -s 2\n"
bindkey -s '\es' "tmux-sessionizer -s 3\n"
