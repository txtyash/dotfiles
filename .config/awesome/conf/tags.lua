local awful = require("awful")

awful.screen.connect_for_each_screen(function(s)
  awful.tag({ "S", "D", "F", "K" }, s, awful.layout.layouts[1])

  awful.tag.add("L", {
    s,
    awful.layout.suit.floating,
  })

end)
