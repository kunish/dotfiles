local wezterm = require("wezterm")

return {
  font = wezterm.font_with_fallback({
    { family = "Ubuntu Mono Ligaturized", weight = "Bold" },
    { family = "小賴字體 等寬 SC" },
  }),
  font_size = 13.6,
  line_height = 1.2,
  color_scheme = "OneHalfBlack (Gogh)",
  audible_bell = "Disabled",
  enable_scroll_bar = false,
  hide_tab_bar_if_only_one_tab = true,
  window_decorations = "RESIZE",
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
