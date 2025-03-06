return {
  "saghen/blink.cmp",
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- disable ghost text as it intefers with copilot
    completion = {
      ghost_text = {
        enabled = false,
      },
    },
  },
}
