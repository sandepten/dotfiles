return {
  "saghen/blink.cmp",
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- Native inline completion already renders suggestions separately.
    completion = {
      ghost_text = {
        enabled = false,
      },
      list = { selection = { preselect = false, auto_insert = true } },
    },
  },
}
