export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

# Go
export PATH=$PATH:~/go/bin
export PATH=$PATH:/usr/local/go/bin
export PATH="$PATH:~/.local/bin"

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

## nvim as default editor
if [ -x "$(command -v nvim)" ]; then
  export EDITOR=nvim
fi

# Shell integrations
# source <(fzf --zsh)
eval "$(zoxide init --cmd cd zsh)"
eval "$(atuin init zsh)"
eval $(thefuck --alias)
# eval "$(fnm env --use-on-cd --shell zsh)"
# fnm
FNM_PATH="/home/sandepten/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "`fnm env`"
fi

# theo video node cache speed up
export NODE_COMPILE_CACHE=~/.cache/nodejs-compile-cache

# antfu ni (choose the right shell)
export NI_DEFAULT_AGENT="pnpm"
export NI_GLOBAL_AGENT="npm"

# fzf catppuccin
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 \
--color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
--color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
--color=selected-bg:#45475A \
--color=border:#6C7086,label:#CDD6F4"


# color of zsh-autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#6c6f85'

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# if whoami is sandeep450.kumar then export node unsafe environment variables as on work laptop zcaler hinders npm install
if [[ "$(whoami)" == "sandeep450.kumar" ]]; then
  # disable TLS certificate validation for Node.js
  export NODE_TLS_REJECT_UNAUTHORIZED=0

  # disable strict SSL checks in npm
  npm config set strict-ssl false >/dev/null 2>&1
fi
