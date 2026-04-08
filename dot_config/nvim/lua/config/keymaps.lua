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
  vim.notify("Inline completion " .. (enabled and "disabled" or "enabled"))
end, { desc = "Toggle Inline Completion" })

