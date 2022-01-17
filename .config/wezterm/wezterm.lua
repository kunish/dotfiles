local wezterm = require("wezterm")

return {
	font = wezterm.font({ "Dank Mono" }, { bold = true }),
	audible_bell = "Disabled",
	font_size = 14,
	color_scheme = "ayu",
	enable_scroll_bar = false,
	hide_tab_bar_if_only_one_tab = true,
	window_decorations = "RESIZE",
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},
}
