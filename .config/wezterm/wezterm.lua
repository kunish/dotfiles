local wezterm = require("wezterm")

return {
	font = wezterm.font("Inconsolata Nerd Font Mono", { bold = true, italic = false }),
	audible_bell = "Disabled",
	font_size = 15,
  line_height = 1.2,
	color_scheme = "OneHalfBlack (Gogh)",
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
