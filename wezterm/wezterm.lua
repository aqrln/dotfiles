local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- config.color_scheme = 'catppuccin-mocha'
config.color_scheme = 'GruvboxDark'
config.font = wezterm.font 'Iosevka Term Medium'
config.font_size = 14
config.freetype_load_target = "Light"
-- config.freetype_load_flags = "NO_HINTING"

config.keys = {
  {
    key = 'g',
    mods = 'SUPER',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'd',
    mods = 'SUPER',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'h',
    mods = 'SUPER|SHIFT',
    action = wezterm.action.ActivatePaneDirection 'Left',
  },
  {
    key = 'j',
    mods = 'SUPER|SHIFT',
    action = wezterm.action.ActivatePaneDirection 'Down',
  },
  {
    key = 'k',
    mods = 'SUPER|SHIFT',
    action = wezterm.action.ActivatePaneDirection 'Up',
  },
  {
    key = 'l',
    mods = 'SUPER|SHIFT',
    action = wezterm.action.ActivatePaneDirection 'Right',
  },
}

return config
