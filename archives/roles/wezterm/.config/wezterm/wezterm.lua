local wezterm = require 'wezterm';

return {
  font = wezterm.font("JetBrains Mono"),
  font_size = 12.0,
  use_ime = true,
  color_scheme = "nord", -- See: https://wezfurlong.org/wezterm/colorschemes/index.html
  hide_tab_bar_if_only_one_tab = true,
  adjust_window_size_when_changing_font_size = false,
  audible_bell = "Disabled",
--	disable_default_key_bindings = true,
}

