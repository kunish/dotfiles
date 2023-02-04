local wezterm = require("wezterm")

return {
	font = wezterm.font("UbuntuMono Nerd Font", { bold = true }),
	audible_bell = "Disabled",
	font_size = 14,
	color_scheme = "OneDark (Gogh)",
	enable_scroll_bar = false,
	hide_tab_bar_if_only_one_tab = true,
	keys = {
		{
			key = "q",
			mods = "CTRL|SHIFT",
			action = wezterm.action.QuickSelect,
		},
		{
			key = "w",
			mods = "SUPER",
			action = wezterm.action.CloseCurrentPane({ confirm = true }),
		},
	},
}
