#!/bin/bash

# Get the list of connected monitors and check if the target monitor is in the list
if hyprctl monitors | grep -q "HDMI-A-1"; then
	# If the monitor is active, disable it
	hyprctl keyword monitor "HDMI-A-1,disable"
else
	# If the monitor is inactive, enable it with your desired settings
	hyprctl keyword monitor "HDMI-A-1,1920x1080@75,0x0,1,transform,1"
fi
