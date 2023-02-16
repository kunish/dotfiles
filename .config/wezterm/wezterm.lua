local wezterm = require("wezterm")

return {
	font = wezterm.font_with_fallback({
		{
			family = "Comic Code Ligatures",
			weight = "Bold",
			harfbuzz_features = { "liga=0" },
		},
		{
			family = "LXGW WenKai Mono",
			weight = "Bold",
		},
	}),
	font_size = 12,
	line_height = 1.1,
	color_scheme = "OneHalfBlack (Gogh)",
	audible_bell = "Disabled",
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
