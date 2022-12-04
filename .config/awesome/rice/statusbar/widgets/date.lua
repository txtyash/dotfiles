local wibox = require "wibox"

local date = wibox.widget {
  spacing = 6,
  {
    format = "%d",
    widget = wibox.widget.textclock,
    align  = "center",
    valign = "center",
  },
  {
    font   = beautiful.icon_font,
    markup = '',
    align  = "center",
    valign = "center",
    widget = wibox.widget.textbox
  },
  {
    id     = "reformat",
    widget = wibox.widget.textbox,
    markup = {
      id     = "day",
      format = "%w",
      widget = wibox.widget.textclock,
      align  = "center",
      valign = "center",
    }
  },
  layout = wibox.layout.fixed.vertical,
}

date.reformat.day.set_markup_silently("x")
