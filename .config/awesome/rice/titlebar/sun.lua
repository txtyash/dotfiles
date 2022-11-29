local awful = require "awful"
local beautiful = require "beautiful"
local gears = require "gears"
-- local wibox = require "wibox"

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
  -- buttons for the titlebar
  local buttons = gears.table.join(
    awful.button({}, 1, function()
      c:emit_signal("request::activate", "titlebar", { raise = true })
      awful.mouse.client.move(c)
    end),
    awful.button({}, 3, function()
      c:emit_signal("request::activate", "titlebar", { raise = true })
      awful.mouse.client.resize(c)
    end)
  )

  awful.titlebar(c, {
    size = 6,
    position = "top",
    bg_focus = beautiful.titlebar_bg_focus,
    bg_normal = beautiful.titlebar_bg_normal,
  })
end)
