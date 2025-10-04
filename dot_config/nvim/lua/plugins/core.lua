return {
  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = true,
      no_italic = true,
      styles = {
        comments = { italic = false },
        keywords = { italic = false },
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
      -- colorscheme = "tokyonight",
      -- colorscheme = "tokyonight-night",
      -- colorscheme = "rose-pine",
    },
  },
}
