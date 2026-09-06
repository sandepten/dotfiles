-- Change the default Omarchy look'n'feel.

-- https://wiki.hypr.land/Configuring/Basics/Variables/#general
hl.config({
  general = {
    -- No gaps between windows or borders.
    gaps_in = 3,
    gaps_out = 3,
    border_size = 1,

    -- Change to niri-like side-scrolling layout.
    layout = "scrolling",
  },
})

-- https://wiki.hypr.land/Configuring/Basics/Variables/#decoration
hl.config({
  decoration = {
    -- macOS-like rounded corners (macOS uses ~10-12px)
    rounding = 12,
    rounding_power = 2.0,

    shadow = {
      enabled = true,
      range = 30,
      render_power = 3,
      color = "rgba(1a1a1a33)",
    },

    blur = {
      enabled = true,
      size = 6,
      passes = 2,
      vibrancy = 0.17,
    },
  },
})

-- https://wiki.hypr.land/Configuring/Basics/Variables/#animations
-- hl.config({
--   animations = {
--     -- Disable all animations.
--     enabled = false,
--   },
-- })

-- https://wiki.hypr.land/Configuring/Basics/Variables/#layout
-- hl.config({
--   layout = {
--     -- Avoid overly wide single-window layouts on wide screens.
--     single_window_aspect_ratio = { 1, 1 },
--   },
-- })

-- https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/
-- hl.config({
--   scrolling = {
--     -- See only one column per screen instead of two.
--     column_width = 0.97,
--   },
-- })
