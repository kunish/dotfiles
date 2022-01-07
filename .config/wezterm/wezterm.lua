local wezterm = require("wezterm")

return {
	font = wezterm.font_with_fallback({
		"Dank Mono",
		"DroidSansMono Nerd Font",
	}, {
		bold = true,
	}),
	font_size = 14,
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
	use_ime = true,
	keys = {
		{ key = "b", mods = "OPT", action = wezterm.action({ SendString = "\x1bb" }) },
		{ key = "f", mods = "OPT", action = wezterm.action({ SendString = "\x1bf" }) },
		{ key = "h", mods = "OPT", action = wezterm.action({ SendString = "\x1bh" }) },
		{ key = "j", mods = "OPT", action = wezterm.action({ SendString = "\x1bj" }) },
		{ key = "k", mods = "OPT", action = wezterm.action({ SendString = "\x1bk" }) },
		{ key = "l", mods = "OPT", action = wezterm.action({ SendString = "\x1bl" }) },
		{ key = "x", mods = "OPT", action = wezterm.action({ SendString = "\x1bx" }) },
	},
}
