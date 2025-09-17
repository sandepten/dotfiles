-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

-- better redo
map("n", "U", ":redo<cr>", { noremap = true, silent = true })

-- moving lines
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")
map("n", "J", "mzJ`z")

-- copilot
map("i", "<C-J>", 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false,
})

-- mapping for movements to stay centered (zz)
map("n", "j", "jzz")
map("n", "k", "kzz")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("n", "J", "mzJ`z") -- keep cursor in the middle when joining lines

-- tmux-sessionizer
map("n", "<C-p>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
map("n", "<M-h>", "<cmd>silent !tmux neww tmux-sessionizer -s 0<CR>")
map("n", "<M-t>", "<cmd>silent !tmux neww tmux-sessionizer -s 1<CR>")
map("n", "<M-n>", "<cmd>silent !tmux neww tmux-sessionizer -s 2<CR>")
map("n", "<M-s>", "<cmd>silent !tmux neww tmux-sessionizer -s 3<CR>")

map("n", "<leader>ot", vim.cmd.ObsidianTemplate, { desc = "Insert template" })
