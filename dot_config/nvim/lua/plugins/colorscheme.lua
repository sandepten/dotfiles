-- Catppuccin fallback — Omarchy's dynamic theme (lua/plugins/theme.lua → ~/.local/state/omarchy/current/theme/neovim.lua)
-- handles `colorscheme = "aether"` / "catppuccin-nvim" etc when `omarchy theme set` is used.
-- This spec is ignored when Omarchy's theme.lua exists, so hotreload works.
local omarchy_theme = vim.fn.expand("~/.local/state/omarchy/current/theme/neovim.lua")
local has_omarchy_theme = vim.fn.filereadable(omarchy_theme) == 1 and vim.fn.filereadable(vim.fn.stdpath("config") .. "/lua/plugins/theme.lua") == 1

if has_omarchy_theme then
  -- Let Omarchy's theme.lua + all-themes.lua + hotreload drive colorscheme
  return {}
end

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
