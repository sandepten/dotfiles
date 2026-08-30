-- Omarchy remote clipboard (OSC52 + Wayland) — needed for tmux/SSH/herdr
require("config.remote_clipboard").setup()

vim.g.snacks_animate = false
vim.opt.relativenumber = false
vim.g.autoformat = false

-- Always keep the cursor vertically centered while scrolling
vim.o.scrolloff = 999
vim.o.smoothscroll = false
vim.o.splitkeep = "screen"
vim.o.linebreak = true
