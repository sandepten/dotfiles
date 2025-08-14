require("lspconfig").gopls.setup({
  settings = {
    gopls = {
      gofumpt = true,
    },
  },
})

return {
  -- record coding time
  { "wakatime/vim-wakatime", lazy = false },

  -- keep cursor centered
  -- {
  --   "arnamak/stay-centered.nvim",
  --   lazy = false,
  --   opts = {},
  -- },
}
