local config_path = vim.fn.expand("~/.markdownlint-cli2.yaml")

return {
  "mfussenegger/nvim-lint",
  optional = true,
  opts = function(_, opts)
    opts.linters = opts.linters or {}
    if vim.uv.fs_stat(config_path) then
      opts.linters["markdownlint-cli2"] = {
        args = { "--config", config_path, "--" },
      }
    end
  end,
}
