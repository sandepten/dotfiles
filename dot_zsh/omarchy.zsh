# Omarchy zsh bridge — aligned to https://github.com/omacom/omarchy-zsh
# Architecture: zoptions (zsh-specific, 249 lines) + shell/all (shared envs/aliases/functions/inits via omadots)
# Shared config lives in /usr/share/omarchy-zsh/shell/*, sourced directly so package updates apply.
# Falls back to legacy /usr/share/omarchy/default/bash/* if omarchy-zsh not installed.

# Prefer official omarchy-zsh package (1.5.0-2)
if [[ -f /usr/share/omarchy-zsh/shell/zoptions ]]; then
  source /usr/share/omarchy-zsh/shell/zoptions 2>/dev/null || true
fi

if [[ -f /usr/share/omarchy-zsh/shell/all ]]; then
  source /usr/share/omarchy-zsh/shell/all 2>/dev/null || true
else
  # Legacy fallback — mirrors previous /usr/share/omarchy/default/bash/rc
  : "${OMARCHY_PATH:=/usr/share/omarchy}"
  export OMARCHY_PATH
  [[ -r "$OMARCHY_PATH/default/bash/env-bootstrap" ]] && source "$OMARCHY_PATH/default/bash/env-bootstrap"
  [[ -r "$OMARCHY_PATH/default/bash/envs" ]] && source "$OMARCHY_PATH/default/bash/envs"
  if [[ -r "$OMARCHY_PATH/default/bash/aliases" ]]; then
    source "$OMARCHY_PATH/default/bash/aliases" 2>/dev/null || true
  fi
  if [[ -d "$OMARCHY_PATH/default/bash/fns" ]]; then
    for f in "$OMARCHY_PATH/default/bash/fns"/*(N.); do
      [[ -r "$f" ]] && source "$f" 2>/dev/null || true
    done
  fi
  # legacy inits (mise/starship/zoxide/try/fzf) — now handled by omarchy-zsh/shell/inits
  if command -v mise &>/dev/null; then eval "$(mise activate zsh 2>/dev/null)" || true; fi
  if command -v zoxide &>/dev/null; then eval "$(zoxide init zsh 2>/dev/null)" || true; fi
  if command -v fzf &>/dev/null; then
    [[ -f /usr/share/fzf/completion.zsh ]] && source /usr/share/fzf/completion.zsh 2>/dev/null || true
    [[ -f /usr/share/fzf/key-bindings.zsh ]] && source /usr/share/fzf/key-bindings.zsh 2>/dev/null || true
  fi
  if [[ -o interactive && "${TERM:-}" != "dumb" ]] && command -v starship &>/dev/null; then
    eval "$(starship init zsh 2>/dev/null)" || true
  fi
  if [[ -r "$OMARCHY_PATH/default/bash/completions" ]]; then
    autoload -Uz bashcompinit 2>/dev/null && bashcompinit 2>/dev/null || true
    source "$OMARCHY_PATH/default/bash/completions" 2>/dev/null || true
  fi
fi

# zoxide: official omarchy-zsh uses `alias cd="zd"` + zd() wrapper (with icon+pwd).
# Your path.zsh previously did `zoxide init --cmd cd` (direct cd). Keep official behavior
# for full omarchy-zsh compliance; uncomment below to restore direct cd:
# if command -v zoxide &>/dev/null; then
#   unalias cd 2>/dev/null; eval "$(zoxide init --cmd cd zsh 2>/dev/null)" || true
# fi

# Local env fallbacks (bashrc compatibility)
[[ -f "$HOME/.local/bin/env" ]] && source "$HOME/.local/bin/env" 2>/dev/null || true
[[ -f "$HOME/.local/share/../bin/env" ]] && source "$HOME/.local/share/../bin/env" 2>/dev/null || true
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env" 2>/dev/null || true

# OMARCHY_PATH already exported via env-bootstrap
