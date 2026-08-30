# Omarchy zsh bridge — migrated from /usr/share/omarchy/default/bash/rc
# Keeps your zsh config (chezmoi) + Omarchy bash things (aliases, functions, env)
# Sourced from ~/.zshrc after path.zsh so user's aliases can overwrite omarchy's on conflict.
# See /usr/share/omarchy/default/bash/* for originals.

: "${OMARCHY_PATH:=/usr/share/omarchy}"
export OMARCHY_PATH

# ---- env (mirrors bash/env-bootstrap + bash/envs) ----
[[ -r "$OMARCHY_PATH/default/bash/env-bootstrap" ]] && source "$OMARCHY_PATH/default/bash/env-bootstrap"
[[ -r "$OMARCHY_PATH/default/bash/envs" ]] && source "$OMARCHY_PATH/default/bash/envs"

# ---- aliases (Omarchy file system, directories, tools) ----
if [[ -r "$OMARCHY_PATH/default/bash/aliases" ]]; then
  # Source Omarchy aliases; user's ~/.zsh/alias.zsh is sourced AFTER this file
  # so chezmoi aliases win on conflict (e.g., `c`, `ls`, `lt`).
  source "$OMARCHY_PATH/default/bash/aliases" 2>/dev/null || true
fi

# ---- functions / fns (compression, drives, herdr, rsyncing, ssh, tmux, worktrees) ----
if [[ -d "$OMARCHY_PATH/default/bash/fns" ]]; then
  for f in "$OMARCHY_PATH/default/bash/fns"/*(N.); do
    [[ -r "$f" ]] && source "$f" 2>/dev/null || true
  done
fi

# ---- zsh-specific init (port of bash/init) ----
# mise
if command -v mise &>/dev/null; then
  eval "$(mise activate zsh 2>/dev/null)" || true
fi

# zoxide — restore user's preferred `zoxide init --cmd cd zsh` (path.zsh does this)
# Omarchy's aliases set `alias cd="zd"` which would clobber it, so re-init.
if command -v zoxide &>/dev/null; then
  eval "$(zoxide init --cmd cd zsh 2>/dev/null)" || true
fi

# fzf — zinit already does `fzf --zsh`, provide system fallback only
if command -v fzf &>/dev/null; then
  if [[ -f /usr/share/fzf/completion.zsh ]]; then
    source /usr/share/fzf/completion.zsh 2>/dev/null || true
  fi
  if [[ -f /usr/share/fzf/key-bindings.zsh ]]; then
    source /usr/share/fzf/key-bindings.zsh 2>/dev/null || true
  fi
fi

# starship — handled via zinit (starship/starship), fallback if zinit not loaded
if [[ -o interactive ]] && [[ "${TERM:-}" != "dumb" ]] && command -v starship &>/dev/null; then
  # zinit's starship plugin defines prompt via init.zsh; if not present, init now
  if ! (( $+functions[starship] )) && [[ -z "${STARSHIP_SHELL:-}" ]]; then
    # Avoid double init when zinit already sourced it
    if ! whence prompt_starship_setup >/dev/null 2>&1; then
      eval "$(starship init zsh 2>/dev/null)" || true
    fi
  fi
fi

# completions — bash completions via bashcompinit for zsh
if [[ -r "$OMARCHY_PATH/default/bash/completions" ]]; then
  autoload -Uz bashcompinit 2>/dev/null && bashcompinit 2>/dev/null || true
  source "$OMARCHY_PATH/default/bash/completions" 2>/dev/null || true
fi

# local bin env (bashrc does `. "$HOME/.local/share/../bin/env"` and `~/.local/bin/env`)
[[ -f "$HOME/.local/bin/env" ]] && source "$HOME/.local/bin/env" 2>/dev/null || true
[[ -f "$HOME/.local/share/../bin/env" ]] && source "$HOME/.local/share/../bin/env" 2>/dev/null || true
# cargo env is already in ~/.zshenv, but keep fallback
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env" 2>/dev/null || true

export OMARCHY_PATH
