# Neovim Config

LazyVim-based Neovim configuration with Catppuccin (transparent, no italics).

## Key Plugins

| Plugin | Purpose |
| --- | --- |
| copilot.vim | AI completions (accept with `<C-J>` in insert mode) |
| cutlass.nvim | Delete without yanking; `x` is the cut key |
| obsidian.nvim | Obsidian vault integration (vault: `~/Documents/obsidian-notes/`) |
| markview.nvim | Rich markdown rendering |
| worklog.nvim | Work logging (`<leader>ha` add, `<leader>hl` list) |
| wakatime | Coding time tracking |
| leetcode.nvim | LeetCode problems (default lang: Java) |

## Custom Keymaps

| Key | Mode | Action |
| --- | --- | --- |
| `U` | Normal | Redo |
| `J` / `K` | Visual | Move selection down / up |
| `J` | Normal | Join lines (cursor stays in place) |
| `<C-J>` | Insert | Accept Copilot suggestion |
| `<C-p>` | Normal | Tmux sessionizer (requires tmux) |
| `<M-h/t/n/s>` | Normal | Tmux sessionizer slots 0-3 |
| `<leader>ot` | Normal | Insert Obsidian template |
| `<leader>ha` | Normal | Add worklog |
| `<leader>hl` | Normal | List worklogs |

## Machine-Specific Assumptions

- **Tmux**: Sessionizer keymaps are only registered inside a tmux session.
- **Obsidian vault**: Expected at `~/Documents/obsidian-notes/`.
- **Markdownlint config**: Uses `~/.markdownlint-cli2.yaml` if it exists.

## LazyVim Extras

Language extras are enabled for: Docker, Git, Go, Helm, Java, JSON, Python,
Rust, SQL, Tailwind, TOML, TypeScript, YAML. Formatting via Prettier and Black.
Linting via ESLint. Re-enable removed extras (angular, cmake, elixir, prisma,
svelte, zig) in `lazyvim.json` if needed.
