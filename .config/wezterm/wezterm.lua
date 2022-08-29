local wezterm = require("wezterm")

return {
	font = wezterm.font("Monaco", { bold = true }),
	audible_bell = "Disabled",
	font_size = 12,
	color_scheme = "ayu",
	enable_scroll_bar = false,
	hide_tab_bar_if_only_one_tab = true,
}
