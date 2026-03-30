return {
  {
    "sandepten/worklog.nvim",
    -- For local development, uncomment the line below and comment the line above
    -- dir = "/Users/sandeep450.kumar/code/projects/personel/worklog.nvim",
    keys = {
      { "<leader>ha", desc = "Add worklog" },
      { "<leader>hl", desc = "List worklogs" },
    },
    config = function()
      require("worklog").setup({
        keymaps = {
          add = "<leader>ha",
          list = "<leader>hl",
        },
      })
    end,
  },
}
