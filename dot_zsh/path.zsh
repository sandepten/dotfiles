#! These are the path requirements for the system

# Go
export PATH=$PATH:~/go/bin
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:/home/sandepten/.local/bin
export PATH="$PATH:/Users/sandeep450.kumar/.local/bin"

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

PATH=~/.console-ninja/.bin:$PATH

# pipx
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
  PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH
# Add Visual Studio Code (code)
# export PATH="\$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(starship init zsh)"

## nvim as default editor
export EDITOR=/opt/homebrew/bin/nvim

# Shell integrations
# source <(fzf --zsh)
eval "$(zoxide init --cmd cd zsh)"
eval "$(atuin init zsh)"
eval $(thefuck --alias)
eval "$(fnm env --use-on-cd --shell zsh)"
