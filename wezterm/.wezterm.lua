local wezterm = require 'wezterm'

local config = wezterm.config_builder()

-- Set to launch with WSL2
config.default_domain = 'WSL:Ubuntu'

config.color_scheme_dirs = { "C:\\Users\\modal\\zenbones\\wezterm\\zenburned.toml" }
config.color_scheme = 'zenburned'

config.font = wezterm.font('Hasklug Nerd Font Mono', { weight = 'Medium' })

config.hide_tab_bar_if_only_one_tab = true

config.audible_bell = "Disabled"

config.max_fps = 120

config.default_cursor_style = "BlinkingBar"

config.initial_cols = 140
config.initial_rows = 60

config.window_decorations = "RESIZE|TITLE"

config.window_padding = {
  left = '2cell',
  right = '2cell',
  top = '1cell',
  bottom = '1cell',
}

config.force_reverse_video_cursor = true

config.ime_preedit_rendering = 'Builtin' -- other option is System
config.colors = {
	compose_cursor = '#f9f9f9',
}

return config
