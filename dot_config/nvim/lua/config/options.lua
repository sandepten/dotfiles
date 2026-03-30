vim.g.snacks_animate = false

-- Keep cursor vertically centered while scrolling
vim.o.scrolloff = 9999
vim.o.smoothscroll = false
vim.o.splitkeep = "screen"
vim.o.linebreak = true

-- Workaround: catppuccin compiled cache doesn't apply opts correctly on Neovim 0.12.
-- Re-compile and re-apply the colorscheme once after the initial (broken) load.
vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("catppuccin_recompile", { clear = true }),
  pattern = "catppuccin*",
  once = true,
  callback = function()
    vim.schedule(function()
      for name, _ in pairs(package.loaded) do
        if name:match("^catppuccin%.") then
          package.loaded[name] = nil
        end
      end
      require("catppuccin").compile()
      vim.cmd.colorscheme("catppuccin")
    end)
  end,
})
