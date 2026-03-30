local map = vim.keymap.set
local wk = require("which-key")

wk.add({
  { "<leader>o", group = "Obsidian" },
  { "<leader>h", group = "Worklog" },
})

map("n", "U", "<cmd>redo<cr>", { desc = "Redo" })

map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down", silent = true })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up", silent = true })
map("n", "J", "mzJ`z", { desc = "Join lines (cursor stays)" })

map("n", "n", "nzzzv", { desc = "Next search result (centered)" })
map("n", "N", "Nzzzv", { desc = "Prev search result (centered)" })
map("n", "<C-d>", "<C-d>zz", { desc = "Half-page down (centered)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half-page up (centered)" })

map("n", "<leader>tc", function()
  local enabled = vim.lsp.inline_completion.is_enabled()
  vim.lsp.inline_completion.enable(not enabled)
  vim.notify("Copilot " .. (enabled and "disabled" or "enabled"))
end, { desc = "Toggle Copilot" })

if vim.env.TMUX then
  map("n", "<C-p>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", { desc = "Tmux sessionizer" })
  map("n", "<M-h>", "<cmd>silent !tmux neww tmux-sessionizer -s 0<CR>", { desc = "Sessionizer slot 0" })
  map("n", "<M-t>", "<cmd>silent !tmux neww tmux-sessionizer -s 1<CR>", { desc = "Sessionizer slot 1" })
  map("n", "<M-n>", "<cmd>silent !tmux neww tmux-sessionizer -s 2<CR>", { desc = "Sessionizer slot 2" })
  map("n", "<M-s>", "<cmd>silent !tmux neww tmux-sessionizer -s 3<CR>", { desc = "Sessionizer slot 3" })
end
