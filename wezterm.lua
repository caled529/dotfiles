local wezterm = require("wezterm")
return {
	font = wezterm.font("FiraCode"),
	font_size = 13.0,
	color_scheme = "Github Dark (Gogh)",
	hide_tab_bar_if_only_one_tab = true,
	keys = {
		{ key = "v", mods = "SUPER", action = wezterm.action.SplitVertical },
		{ key = "s", mods = "SUPER", action = wezterm.action.SplitHorizontal },
		{ key = "h", mods = "SUPER", action = wezterm.action.ActivatePaneDirection("Left") },
		{ key = "j", mods = "SUPER", action = wezterm.action.ActivatePaneDirection("Down") },
		{ key = "k", mods = "SUPER", action = wezterm.action.ActivatePaneDirection("Up") },
		{ key = "l", mods = "SUPER", action = wezterm.action.ActivatePaneDirection("Right") },
		{ key = "h", mods = "SUPER|SHIFT", action = wezterm.action.SplitPane({ direction = "Left" }) },
		{ key = "j", mods = "SUPER|SHIFT", action = wezterm.action.SplitPane({ direction = "Down" }) },
		{ key = "k", mods = "SUPER|SHIFT", action = wezterm.action.SplitPane({ direction = "Up" }) },
		{ key = "l", mods = "SUPER|SHIFT", action = wezterm.action.SplitPane({ direction = "Right" }) },
		{ key = "x", mods = "SUPER", action = wezterm.action.CloseCurrentPane({ confirm = true }) },
		{ key = "t", mods = "SUPER", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
		{ key = "1", mods = "SUPER", action = wezterm.action.ActivateTab(0) },
		{ key = "2", mods = "SUPER", action = wezterm.action.ActivateTab(1) },
		{ key = "3", mods = "SUPER", action = wezterm.action.ActivateTab(2) },
		{ key = "4", mods = "SUPER", action = wezterm.action.ActivateTab(3) },
		{ key = "5", mods = "SUPER", action = wezterm.action.ActivateTab(4) },
		{ key = "6", mods = "SUPER", action = wezterm.action.ActivateTab(5) },
		{ key = "7", mods = "SUPER", action = wezterm.action.ActivateTab(6) },
		{ key = "8", mods = "SUPER", action = wezterm.action.ActivateTab(7) },
		{ key = "9", mods = "SUPER", action = wezterm.action.ActivateTab(8) },
		{ key = "0", mods = "SUPER", action = wezterm.action.ActivateTab(9) },
	},
}