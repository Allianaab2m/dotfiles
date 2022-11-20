local wezterm = require 'wezterm'

local SOLID_LEFT_ARROW = utf8.char(0xe0b2)

local SOLID_RIGHT_ARROW = utf8.char(0xe0b0)

wezterm.on(
  'format-tab-title',
  function(tab, tabs, panes, config, hover, max_width)
    local background = '#45475a'
    local foreground = '#cdd6f4'
    local edge_background = '#11111b'
    local edge_foreground = background

    if tab.is_active then
      return {
        { Background = { Color = background } },
        { Foreground = { Color = foreground } },
        { Text = ' ' .. tab.active_pane.title .. ' ' },
      }
    else
      return {
        { Background = { Color = edge_background } },
        { Foreground = { Color = edge_foreground } },
        { Text = ' ' .. tab.active_pane.title .. ' ' },
      }
    end
  end
)

return {
  font = wezterm.font 'PlemolJP35 Console NF',
  font_size = 10.0,
  use_fancy_tab_bar = false,
  tab_bar_at_bottom = true,
  color_scheme_dirs = {
    '~/.config/wezterm/colors/penumbra-dark.toml',
    '~/.config/wezterm/colors/penumbra-dark_plus.toml',
    '~/.config/wezterm/colors/penumbra-dark_plusplus.toml',
  },
  xim_im_name = 'fcitx',
  color_scheme = 'penumbra-dark-plusplus',
  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },
}
