-- C:\Users\modal\.wezterm.lua

local wezterm = require 'wezterm'

local config = wezterm.config_builder()
config.term = 'wezterm'

-- Set to launch with WSL2
config.default_domain = 'WSL:Ubuntu'

local color_scheme_file = "C:\\Users\\modal\\zenbones\\wezterm\\zenburned.toml"
config.color_scheme_dirs = { "C:\\Users\\modal\\zenbones\\wezterm\\zenburned.toml" }
config.color_scheme = 'zenburned'

config.font = wezterm.font('Hasklug Nerd Font Mono', { weight = 'Medium' })
config.font_size = 11.0

config.hide_tab_bar_if_only_one_tab = false
config.use_fancy_tab_bar = true

config.audible_bell = "Disabled"

config.max_fps = 120

config.default_cursor_style = "BlinkingBar"

config.initial_cols = 140
config.initial_rows = 60

-- config.window_decorations = "RESIZE|TITLE"
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"

config.window_padding = {
  left = '2cell',
  right = '2cell',
  top = '1cell',
  bottom = '1cell',
}

config.window_frame = {
  font = wezterm.font { family = 'Roboto' },
  font_size = 10.0,
}


colors, metadata = wezterm.color.load_scheme(color_scheme_file)
config.colors = {
  compose_cursor = '#f9f9f9',
  tab_bar = {
    active_tab = {
      -- fg_color = "#f0e4cf",
      -- fg_color = "white",
      -- bg_color = "#404040",
      fg_color = colors.foreground,
      bg_color = colors.background,
      underline = "Double",
      intensity = "Bold",
    }
  }
}



config.force_reverse_video_cursor = true

config.ime_preedit_rendering = 'Builtin' -- other option is System
-- config.colors = {
-- 	compose_cursor = '#f9f9f9',
-- }

config.scrollback_lines = 10000

wezterm.on("toggle-tabbar", function(window, _)
	local overrides = window:get_config_overrides() or {}
	if overrides.enable_tab_bar == false then
		wezterm.log_info("tab bar shown")
		overrides.enable_tab_bar = true
	else
		wezterm.log_info("tab bar hidden")
		overrides.enable_tab_bar = false
	end
	window:set_config_overrides(overrides)
end)

config.keys = {
  { key = ';', mods = 'CTRL', action = wezterm.action.EmitEvent 'toggle-tabbar' },
}

return config
