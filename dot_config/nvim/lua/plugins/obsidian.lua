local vault = vim.fn.expand("~/code/projects/personel/obsidian-notes")
local vault_exists = vim.uv.fs_stat(vault) ~= nil

return {
  {
    "obsidian-nvim/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    enabled = vault_exists,
    lazy = true,
    cmd = "Obsidian",
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
          path = vault,
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
        date_format = "YYYY-MM-DD",
        time_format = "HH:mm",
      },

      daily_notes = {
        -- "YYYY/YYYY-MM-DD" nests dailies per year: Calendar/2026/2026-08-25.md
        folder = "Calendar",
        date_format = "YYYY/YYYY-MM-DD",
        default_tags = { "journal" },
        template = "Daily note.md",
      },
    },
  },
}
