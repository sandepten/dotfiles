return {
  "gbprod/cutlass.nvim",
  event = "VeryLazy",
  opts = {
    cut_key = "x",
    -- Keep flash.nvim's s/S jump mappings (cutlass would otherwise remap them).
    exclude = { "ns", "nS" },
  },
}
