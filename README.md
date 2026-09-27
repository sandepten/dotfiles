# I do dotfiles

These are my dotfiles used on both Arch and Mac. I use [chezmoi](https://github.com/twpayne/chezmoi) to manage them.

## Install

First install chezmoi: [install chezmoi](https://www.chezmoi.io/install)

Then run:

```sh
chezmoi init --apply https://github.com/sandepten/dotfiles.git
```

## Tools I use

- Neovim
- Tmux
- Zsh
- eza (ls replacement)
- yazi (TUI file manager)
- fzf (fuzzy finder)
- bat (cat replacement with syntax highlighting)
- zoxide (cd command replacement)
- atuin (command line tool for remembering and suggesting commands)
- niri (scrollable wayland compositor)
- ghostty
- starship

## Agent guidance (when editing this repo)

This repo is the chezmoi source for personal dotfiles used on Arch Linux and macOS.

### Repo shape

- `dot_*` entries map to paths in `$HOME`.
- Most config lives under `dot_config/`, especially `nvim`, `hypr`, `niri`, `tmux`, `kitty`, `ghostty`, `bat`, `btop`, `yazi`, and `starship`.
- Shell setup is centered around `dot_zshrc.tmpl`, `dot_zsh/`, `dot_profile`, and `dot_gitconfig`.
- `dot_config/nvim/` has its own `README.md`; `dot_config/opencode/` is bundled agent/skill content, not core machine config.

### Chezmoi conventions

- `dot_`: becomes a dotfile or dot-directory in the target home directory.
- `private_`: private/sensitive content; treat carefully and avoid committing secrets.
- `executable_`: installed with the executable bit.
- `.tmpl`: Go template source. Keep template syntax valid. Two keys are required and are referenced directly rather than through a `hasKey` guard, so a machine missing them fails with the key name instead of rendering a silently different shell: `is_work` and `default_node_agent`.
- `.chezmoiignore` is also templated. Its entries are **destination**-relative, so `.config/hypr` and not `dot_config/hypr`. A source-relative entry matches nothing and is dropped without warning.
- `.new` files are alternate/reference configs and deploy as separate files with the `.new` suffix.
- `private_` templates reference their values from `[data]` in the local `~/.config/chezmoi/chezmoi.toml` rather than storing them here, so no PAT enters this repository. `missingkey=error` makes a machine that has not set them fail loudly.

## Required local config

`chezmoi init` on a new machine stops with `map has no entry for key "is_work"` until these are set. Create `~/.config/chezmoi/chezmoi.toml` (mode 600) before the first apply:

```toml
[data]
  is_work = true
  default_node_agent = "bun"
```

`is_work` enables the corporate TLS workaround and the OMZ snippet. `default_node_agent` is what `ni` uses. Add the `ADO_*` keys here too if you use the Azure DevOps env file.

### Editing notes

- Prefer editing the chezmoi source here, then verify with `chezmoi diff` and apply with `chezmoi apply`.
- Be careful with OS-specific branches in templates so Linux and macOS behavior do not drift accidentally.
- For Hyprland, prefer `dot_config/hypr/custom/*` for local overrides; `dot_config/hypr/hyprland.conf` sources those files.
- `dot_zsh/path.zsh.tmpl` contains work-only Node/npm TLS relaxations; do not broaden them casually.
- `dot_zshrc.tmpl` has a marked `chezmoi managed toolchain` region. CLI installers append PATH lines inside those markers. An installer appending outside them will be deleted by the next apply.
- Shell startup is pinned by an equivalence harness. Before changing `path.zsh`, `zinit.zsh` or `zshrc`, capture the shell state and diff it, and re-check startup timing. A change that only removes a subprocess is worth more than one that adds structure.

**Note:** Home `~/AGENTS.md` is **not** managed by chezmoi (HCMP agent standing policy). Do not re-add `AGENTS.md` to this source.
