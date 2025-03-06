return {
  "gbprod/cutlass.nvim", -- Cutlass overrides the delete operations to actually just delete and not affect the current yank.
  lazy = false,
  opts = {
    cut_key = "x",
    exclude = { "ns", "nS" },
  },
}
