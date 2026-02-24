return {
  {
    "sandepten/worklog.nvim",
    -- For local development, uncomment the line below and comment the line above
    -- dir = "/Users/sandeep450.kumar/code/projects/personel/worklog.nvim",
    lazy = false,
    config = function()
      require("worklog").setup({
        -- Optional: customize keybindings
        keymaps = {
          add = "<leader>ha",
          list = "<leader>hl",
        },
      })
    end,
  },
}
