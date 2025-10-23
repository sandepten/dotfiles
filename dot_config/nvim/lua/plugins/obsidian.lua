return {
  {
    "obsidian-nvim/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    ---@module 'obsidian'
    ---@type obsidian.config
    opts = {
      disable_frontmatter = false,
      ui = {
        enable = false,
      },
      workspaces = {
        {
          name = "personal",
          path = "~/Documents/obsidian-notes/",
        },
      },
      notes_subdir = "Cards",

      -- new notes
      new_notes_location = "Cards",
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
      completion = {
        blink = true,
        create_new = true,
      },
      picker = {
        name = "snacks.pick",
      },
    },
  },
  {
    "OXY2DEV/markview.nvim",
    lazy = false,

    -- For blink.cmp's completion
    -- source
    -- dependencies = {
    --     "saghen/blink.cmp"
    -- },
  },
}
