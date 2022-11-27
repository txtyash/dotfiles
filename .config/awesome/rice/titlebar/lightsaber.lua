local awful = require("awful")
local gears = require("gears")
-- local wibox = require("wibox")

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
    bg_focus = "#ffff00",
    bg_normal = "#000",
  })
  -- :setup {
  -- { -- Left
  --   spacing = 5,
  --   awful.titlebar.widget.iconwidget(c),
  --   buttons = buttons,
  --   layout  = wibox.layout.fixed.horizontal
  -- },
  -- { -- Middle
  --   { -- Title
  --     widget = awful.titlebar.widget.titlewidget(c)
  --   },
  --   buttons = buttons,
  --   layout  = wibox.layout.flex.horizontal
  -- },
  -- { -- Right
  --   spacing = 4,
  --   awful.titlebar.widget.closebutton(c),
  -- awful.titlebar.widget.floatingbutton(c),
  -- awful.titlebar.widget.minimizebutton(c),
  -- awful.titlebar.widget.maximizedbutton(c),
  -- awful.titlebar.widget.stickybutton(c),
  -- awful.titlebar.widget.ontopbutton(c),
  -- layout = wibox.layout.fixed.horizontal()
  -- },
  --   layout = wibox.layout.align.horizontal
  -- }
end)
