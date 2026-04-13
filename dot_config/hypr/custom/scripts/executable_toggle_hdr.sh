#!/bin/bash

if hyprctl monitors | grep -q "DP-1"; then
	CURRENT=$(hyprctl monitors | grep "hdr" | awk '{print $2}')
	if [ "$CURRENT" = "hdr" ]; then
		hyprctl keyword monitor "DP-1,2560x1440@144,0x0,1,transform,0"
		notify-send "HDR" "HDR disabled" -u low
	else
		hyprctl keyword monitor "DP-1,2560x1440@144,0x0,1,transform,0,bitdepth, 10, cm, hdr, sdrbrightness, 1.2, sdrsaturation, 0.98"
		notify-send "HDR" "HDR enabled" -u low
	fi
fi
