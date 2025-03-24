#! These are the path requirements for the system

# Go
export PATH=$PATH:~/go/bin
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:/home/sandepten/.local/bin

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# pipx
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
  PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

if [ "$(uname)" = "Darwin" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
eval "$(starship init zsh)"

## nvim as default editor
if [ -x "$(command -v nvim)" ]; then
  export EDITOR=nvim
fi

# Shell integrations
# source <(fzf --zsh)
eval "$(zoxide init --cmd cd zsh)"
eval "$(atuin init zsh)"
eval $(thefuck --alias)
eval "$(fnm env --use-on-cd --shell zsh)"
