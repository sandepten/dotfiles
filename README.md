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
- `.tmpl`: Go template source. Keep template syntax valid; this repo uses `.chezmoi.os`, `.default_node_agent`, and `.is_work`.
- `.chezmoiignore` is also templated; for example, `dot_zsh/arch.zsh` is Linux-only.
- `.new` files are alternate/reference configs and deploy as separate files with the `.new` suffix.

### Editing notes

- Prefer editing the chezmoi source here, then verify with `chezmoi diff` and apply with `chezmoi apply`.
- Be careful with OS-specific branches in templates so Linux and macOS behavior do not drift accidentally.
- For Hyprland, prefer `dot_config/hypr/custom/*` for local overrides; `dot_config/hypr/hyprland.conf` sources those files.
- `dot_zsh/path.zsh.tmpl` contains work-only Node/npm TLS relaxations; do not broaden them casually.
- Some template data comes from local chezmoi config outside this repo, so not every template variable is defined in-source.

**Note:** Home `~/AGENTS.md` is **not** managed by chezmoi (HCMP agent standing policy). Do not re-add `AGENTS.md` to this source.
