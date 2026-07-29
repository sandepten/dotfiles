return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      transparent_background = true,
      no_italic = true,
    },
  },
  { "folke/tokyonight.nvim", enabled = false },
  {
    "LazyVim/LazyVim",
    opts = {
      -- Neovim 0.12+ ships a builtin `catppuccin`; use the plugin port name.
      colorscheme = "catppuccin-nvim",
    },
  },
}
