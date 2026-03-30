return {
  {
    "obsidian-nvim/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    keys = {
      { "<leader>ot", "<Cmd>Obsidian template<CR>", desc = "Insert template" },
      { "<leader>on", "<Cmd>Obsidian new<CR>", desc = "New note" },
      { "<leader>od", "<Cmd>Obsidian today<CR>", desc = "Daily note" },
      { "<leader>os", "<Cmd>Obsidian search<CR>", desc = "Search notes" },
      { "<leader>ob", "<Cmd>Obsidian backlinks<CR>", desc = "Backlinks" },
    },
    ---@module 'obsidian'
    ---@type obsidian.config
    opts = {
      legacy_commands = false,
      workspaces = {
        {
          name = "personal",
          path = "~/code/projects/personel/obsidian-notes/",
        },
      },
      notes_subdir = "Cards",

      ---@param title string|?
      ---@return string
      note_id_func = function(title)
        return title or tostring(os.time())
      end,

      templates = {
        folder = "Extras/Templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
        -- A map for custom variables, the key should be the variable and the value a function
        substitutions = {},
      },
    },
  },
  {
    "OXY2DEV/markview.nvim",
    ft = "markdown",
  },
}
