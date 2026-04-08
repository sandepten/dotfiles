vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
  group = vim.api.nvim_create_augroup("env_no_diagnostics", { clear = true }),
  pattern = ".env*",
  callback = function(e)
    vim.diagnostic.enable(false, { bufnr = e.buf })
  end,
})

-- Workaround: catppuccin compiled cache doesn't apply opts correctly on Neovim 0.12.
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
