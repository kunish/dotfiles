local wezterm = require("wezterm")

return {
	font = wezterm.font("DroidSansMono Nerd Font", { bold = true }),
	font_size = 12,
	color_scheme = "Gruvbox Dark",
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
