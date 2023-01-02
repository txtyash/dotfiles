local awful = require 'awful'
local bling = require 'modules.bling'

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
  awful.layout.suit.tile.left,
  awful.layout.suit.max.fullscreen,
}

--[[ More Layouts
* awful.layout.suit.floating:
  * All windows floating
awful.layout.suit.tile,
awful.layout.suit.tile.bottom,
awful.layout.suit.tile.top,
awful.layout.suit.fair,
awful.layout.suit.fair.horizontal,
awful.layout.suit.spiral,
awful.layout.suit.spiral.dwindle,
awful.layout.suit.max.fullscreen,
awful.layout.suit.magnifier,
awful.layout.suit.corner.nw,
awful.layout.suit.corner.ne,
awful.layout.suit.corner.sw,
awful.layout.suit.corner.se,

bling.layout.mstab
bling.layout.centered
bling.layout.vertical
bling.layout.horizontal
bling.layout.equalarea
bling.layout.deck
]] --
