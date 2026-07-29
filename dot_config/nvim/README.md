# Neovim Config

LazyVim-based Neovim configuration with Catppuccin, native Copilot inline
completion, and a small set of local plugin overrides.

## Key Plugins

| Plugin | Purpose |
| --- | --- |
| `catppuccin` | Transparent Catppuccin theme (`catppuccin-nvim`) with italics disabled |
| `blink.cmp` | Completion menu with ghost text disabled so native inline suggestions stay clear |
| `obsidian.nvim` | Obsidian workflow for `~/code/projects/personel/obsidian-notes/` (skipped if vault missing) |
| `worklog.nvim` | Work logging with quick add and list mappings |
| `vim-wakatime` | Coding time tracking |
| `cutlass.nvim` | Delete without yanking; `x` is the cut key |
| `hardtime.nvim` | Hint-mode motion training; quiet (no popup notifications) |
| `neo-tree.nvim` | File explorer on the right side |
| `leetcode.nvim` | LeetCode workflow with Java as the default language (`:Leet`) |

## Custom Keymaps

| Key | Mode | Action |
| --- | --- | --- |
| `U` | Normal | Redo |
| `J` / `K` | Visual | Move selection down / up |
| `J` | Normal | Join lines and keep the cursor in place |
| `<leader>tc` | Normal | Toggle native inline completion |
| `<leader>ot` | Normal | Insert Obsidian template |
| `<leader>on` | Normal | Create a new Obsidian note |
| `<leader>od` | Normal | Open today's daily note |
| `<leader>os` | Normal | Search Obsidian notes |
| `<leader>ob` | Normal | Show Obsidian backlinks |
| `<leader>ha` | Normal | Add worklog entry |
| `<leader>hl` | Normal | List worklog entries |

## Options of Note

- `scrolloff = 999` keeps the cursor vertically centered while scrolling.
- TypeScript LSP uses `tsgo` via the LazyVim `lang.typescript.tsgo` extra.

## Machine-Specific Assumptions

- Obsidian vault lives at `~/code/projects/personel/obsidian-notes/`.
- If `~/.markdownlint-cli2.yaml` exists, markdown linting will use it.
- Native Copilot inline completion expects Neovim 0.12+.

## LazyVim Extras

Enabled extras currently cover:

- AI: Copilot chat, Copilot native
- Coding: mini-surround, yanky
- Editor: dial, fzf, illuminate, inc-rename, neo-tree
- Formatting: black, prettier
- Languages: Angular, Docker, Git, Go, Helm, Java, JSON, Markdown, Prisma, Python, Rust, SQL, Svelte, Tailwind, TOML, TypeScript, TypeScript OXC, TypeScript tsgo, YAML
- Utilities: chezmoi, dot, mini-hipatterns
