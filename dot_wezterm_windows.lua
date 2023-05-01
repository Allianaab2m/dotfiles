local wezterm = require("wezterm")

return {
	default_prog = { "pwsh" },
	font = wezterm.font_with_fallback({
		"PlemolJP35 Console NF",
	}),
	color_scheme = "Catppuccin Mocha",
	line_height = 0.9,
	font_size = 10.0,
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},
	hide_tab_bar_if_only_one_tab = true,
	ssh_domains = {
		{
			name = "raspi4",
			remote_address = "raspi4",
			username = "alliana",
		},
	},
}
