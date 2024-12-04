-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.color_scheme = "Catppuccin Mocha"
config.color_scheme = "Tokyo Night"
config.window_background_opacity = 0.95

-- font
config.font_size = 18
config.font = wezterm.font("GeistMono Nerd Font", { weight = "DemiBold", italic = false })
-- config.font = wezterm.font_with_fallback({
-- 	"JetBrains Mono",
-- })
config.default_cursor_style = "SteadyBar"
config.window_padding = {
	top = 0,
	bottom = 0,
}
config.line_height = 1.15
-- and finally, return the configuration to wezterm
return config
