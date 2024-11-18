local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.color_scheme = 'GruvboxLight'
config.font = wezterm.font 'FiraMono Nerd Font'
config.font_size = 14
config.freetype_load_target = "Normal"
config.freetype_load_flags = "NO_HINTING"

config.window_decorations = "RESIZE"
-- config.use_fancy_tab_bar = false

config.window_padding = {
  left = '0cell',
  right = '0cell',
  top = '0cell',
  bottom = '0cell',
}

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
