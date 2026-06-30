# AGENTS.md

This repo is the chezmoi source for personal dotfiles used on Arch Linux and macOS.

## Repo Shape

- `dot_*` entries map to paths in `$HOME`.
- Most config lives under `dot_config/`, especially `nvim`, `hypr`, `niri`, `tmux`, `kitty`, `ghostty`, `bat`, `btop`, `yazi`, and `starship`.
- Shell setup is centered around `dot_zshrc.tmpl`, `dot_zsh/`, `dot_profile`, and `dot_gitconfig`.
- `dot_config/nvim/` has its own `README.md`; `dot_config/opencode/` is bundled agent/skill content, not core machine config.

## Chezmoi Conventions

- `dot_`: becomes a dotfile or dot-directory in the target home directory.
- `private_`: private/sensitive content; treat carefully and avoid committing secrets.
- `executable_`: installed with the executable bit.
- `.tmpl`: Go template source. Keep template syntax valid; this repo uses `.chezmoi.os`, `.default_node_agent`, and `.is_work`.
- `.chezmoiignore` is also templated; for example, `dot_zsh/arch.zsh` is Linux-only.
- `.new` files are alternate/reference configs and deploy as separate files with the `.new` suffix.

## Editing Notes

- Prefer editing the chezmoi source here, then verify with `chezmoi diff` and apply with `chezmoi apply`.
- Be careful with OS-specific branches in templates so Linux and macOS behavior do not drift accidentally.
- For Hyprland, prefer `dot_config/hypr/custom/*` for local overrides; `dot_config/hypr/hyprland.conf` sources those files.
- `dot_zsh/path.zsh.tmpl` contains work-only Node/npm TLS relaxations; do not broaden them casually.
- Some template data comes from local chezmoi config outside this repo, so not every template variable is defined in-source.

## Bootstrap

`chezmoi init --apply https://github.com/sandepten/dotfiles.git`
