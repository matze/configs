local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.font_size = 12
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

local function scheme_for_appearance(appearance)
  if appearance:find 'Dark' then
    return 'jellybeans-nvim'
  else
    return 'jellybeans-nvim-muted-light'
  end
end

wezterm.on('window-config-reloaded', function(window, pane)
  local overrides = window:get_config_overrides() or {}
  local appearance = window:get_appearance()
  local scheme = scheme_for_appearance(appearance)

  if overrides.color_scheme ~= scheme then
    overrides.color_scheme = scheme
    window:set_config_overrides(overrides)
  end
end)

require('multiplexer').apply(config)

return config
