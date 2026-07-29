return {
  {
    "m4xshen/hardtime.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {
      -- Warn instead of hard-blocking; scrolloff=999 already slows hjkl spam.
      restriction_mode = "hint",
      notification = false,
      disabled_filetypes = {
        ["leetcode.nvim"] = true,
      },
    },
  },
}
