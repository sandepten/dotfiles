# Function to find and navigate to Git-initialized code folders
fcd() {
  local selected_folder

  # Find all directories containing a .git folder, excluding the top-level .git itself
  # and hidden directories like .config, .cache etc.
  selected_folder=$(find ~/code -type d -name ".git" -prune -o -type d -print 2>/dev/null |
    grep "/.git$" |
    sed 's/\/.git$//' |
    fzf --prompt="Select a Git repository: " \
        --height=40% \
        --layout=reverse \
        --border \
        --exit-0) # Exit with 0 if no selection is made (e.g., Ctrl+C)

  if [[ -n "$selected_folder" ]]; then
    echo "Changing directory to: $selected_folder"
    cd "$selected_folder" || {
      echo "Error: Could not change directory to $selected_folder"
      return 1
    }
    echo "Opening Neovim in: $selected_folder"
    nvim
  else
    echo "No folder selected."
  fi
}

# Add an alias for convenience
alias fcd='fcd'
