local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- config.color_scheme = "Catppuccin Mocha"
config.color_scheme = "Tokyo Night"
config.window_background_opacity = 0.9

-- font
config.font_size = 18
-- config.font = wezterm.font("MonaspiceNe Nerd Font Mono", { weight = "Medium", italic = false })
config.font = wezterm.font({
	-- family = "MonaspiceAr Nerd Font Mono",
	-- family = "GeistMono Nerd Font Mono",
	family = "JetBrainsMono Nerd Font",
	-- weight = "DemiBold",
	weight = "Medium",
	italic = false,
	harfbuzz_features = {
		"calt=1",
		"liga=1",
		"ss01=1",
		"ss02=1",
		"ss03=1",
		"ss04=1",
		"ss05=1",
		"ss06=1",
		"ss07=1",
		"ss08=1",
		"ss09=1",
	},
})

config.default_cursor_style = "SteadyBar"
config.window_padding = {
	top = 0,
	bottom = 0,
}
-- config.line_height = 1.1

return config
