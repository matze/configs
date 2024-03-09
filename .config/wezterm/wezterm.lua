local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.font_size = 14.5
config.color_scheme = 'Rasi (terminal.sexy)'
config.enable_tab_bar = false
config.use_resize_increments = true
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
config.warn_about_missing_glyphs = false
config.keys = {
  {
    key = 'F11',
    action = wezterm.action.ToggleFullScreen,
  },
}

return config
