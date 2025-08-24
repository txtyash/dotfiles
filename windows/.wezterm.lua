local wezterm = require("wezterm")

local config = {
	font_size = 11,
	default_prog = { "nu" },
	keys = {
		{
			key = "t",
			mods = "ALT",
			action = wezterm.action.SpawnTab("CurrentPaneDomain"),
		},
		{
			key = "w",
			mods = "ALT",
			action = wezterm.action.CloseCurrentTab({ confirm = true }),
		},
		{
			key = "k",
			mods = "ALT",
			action = wezterm.action.ActivateTabRelative(-1),
		},
		{
			key = "j",
			mods = "ALT",
			action = wezterm.action.ActivateTabRelative(1),
		},
	},
}

return config
