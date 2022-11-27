local wezterm = require 'wezterm'
return {
  -- default_prog = { '/usr/bin/fish', '-l' },
  default_prog = { '/usr/bin/zellij' },
  color_scheme = "Atelier Dune Light (base16)",
  tab_bar_at_bottom = true,
  default_cursor_style = 'BlinkingUnderline',
  action = wezterm.action.CloseCurrentTab { confirm = false },
  window_close_confirmation = "NeverPrompt",
  keys = {
    { key = 'v', mods = 'ALT', action = 'ActivateCopyMode' },
  },
  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },
}
