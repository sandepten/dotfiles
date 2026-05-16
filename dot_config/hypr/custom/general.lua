-- This file will not be overwritten across dots-hyprland updates.
-- The file name is for the sake of organization and does not matter
-- See the corresponding files in ~/.config/hypr/hyprland for examples
-- monitor=DP-1,2560x1440@143.97301,1080x0,1,transform,0, cm, auto
-- monitor=HDMI-A-1,disable
-- # monitor=HDMI-A-1,1920x1080@75,0x0,1,transform,1
hl.monitor({
	output = "DP-1",
	mode = "2560x1440@143.97",
	position = "1080x0",
	scale = "1",
	transform = 0,
})
hl.monitor({
	output = "HDMI-A-1",
	disabled = true,
	-- mode = "1920x1080@75",
	-- position = "0x0",
	-- scale = "1",
	-- transform = 1,
})
