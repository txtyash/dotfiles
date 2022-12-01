local wibox = require("wibox")
local gears = require("gears")
local debug = require("gears.debug")
local beautiful = require("beautiful")
local awful = require("awful")
local rubato = require("modules.rubato")
local color = require("modules.color")
local helpers = require("lib/helpers")

return function(s)

  local volbar = wibox.widget {
    {
      {
        {
          {
            id               = "vol",
            widget           = wibox.widget.slider,
            bar_shape        = gears.shape.rounded_rect,
            bar_height       = 4,
            bar_color        = beautiful.lbg,
            bar_active_color = beautiful.white,
            handle_color     = beautiful.white,
            handle_shape     = gears.shape.circle,
            handle_width     = 4,
            handle_cursor    = "sb_v_double_arrow",
            maximum          = 100,
            minimum          = 0,
            forced_width     = 80,
          },
          id        = "rotate",
          widget    = wibox.container.rotate,
          direction = "east"
        },
        id     = "margin",
        widget = wibox.container.margin,
        top    = 8,
        bottom = 8
      },
      id       = "reveal",
      widget   = wibox.container.constraint,
      strategy = "max",
      height   = 0
    },
    {
      {
        {
          id            = "icon",
          widget        = wibox.widget.textbox,
          markup        = "",
          align         = "center",
          valign        = "center",
          font          = beautiful.icon_font,
          forced_height = 28
        },
        widget = wibox.container.background,
        id     = "bgcol"
      },
      widget = wibox.container.background,
      shape  = helpers.rrect(4),
      id     = "shape"
    },
    layout = wibox.layout.fixed.vertical
  }

  local mute_status = wibox.widget {
    {
      id            = "is_mute",
      widget        = wibox.widget.textbox,
      markup        = "sex",
      align         = "center",
      valign        = "center",
      font          = "JetBrains Mono Nerd Font Mono 18",
      forced_height = 28
    },
  }

  local vol = volbar.reveal.margin.rotate.vol
  local is_mute = mute_status.is_mute
  local icon = volbar.shape.bgcol.icon

  local icon_update =
  function()
    awful.spawn.easy_async_with_shell("pamixer --get-mute", function(stdout)

      is_mute:set_markup_silently(stdout)

      if is_mute.markup == "true\n" then
        icon:set_markup_silently("")
      elseif is_mute.markup == "false\n" then
        icon:set_markup_silently("")
      else
        icon:set_markup_silently("?")
      end

    end)
  end

  icon_update()

  volbar.shape:buttons(gears.table.join(
    awful.button({}, 1, function()

      awful.spawn.easy_async_with_shell("pamixer --toggle-mute", function()
        icon_update()
      end)

    end),
    awful.button({}, 4, function() vol:set_value(vol.value - 3) end),
    awful.button({}, 5, function() vol:set_value(vol.value + 3) end)))

  local volume_slide = rubato.timed {
    pos        = 0,
    duration   = 0.5,
    intro      = 0,
    outro      = 0.4,
    easing     = rubato.quadratic,
    subscribed = function(pos) volbar.reveal:set_height(pos) end
  }

  volbar:connect_signal("mouse::enter", function()
    awful.spawn.easy_async_with_shell("pamixer --get-volume", function(stdout)
      vol:set_value(tonumber(stdout))
    end)
    volume_slide.target = 80
  end)

  volbar:connect_signal("mouse::leave", function()
    volume_slide.target = 0
  end)

  local dbg = color.color { hex = beautiful.dbg }
  local lbg = color.color { hex = beautiful.lbg }

  local btntrans = color.transition(dbg, lbg)
  local btnanim = rubato.timed {
    duration   = 0.2,
    intro      = 0.1,
    subscribed = function(pos) volbar.shape.bgcol.bg = btntrans(pos).hex end
  }

  volbar.shape:connect_signal("mouse::enter", function()
    btnanim.target = 1
    local w = mouse.current_wibox
    if w then
      old_cursor, old_wibox = w.cursor, w
      w.cursor = "hand1"
    end
  end)

  volbar.shape:connect_signal("mouse::leave", function()
    btnanim.target = 0
    if old_wibox then
      old_wibox.cursor = old_cursor
      old_wibox = nil
    end
  end)

  vol:connect_signal("mouse::press", function()
    local w = mouse.current_wibox
    if w then
      old_cursor, old_wibox = w.cursor, w
      w.cursor = "sb_double_arrow"
    end
  end)

  vol:connect_signal("mouse::release", function()
    if old_wibox then
      old_wibox.cursor = old_cursor
      old_wibox = nil
    end
  end)

  vol:connect_signal("property::value", function()
    awful.spawn.with_shell("pamixer --set-volume " .. vol:get_value())
  end)
  return helpers.embox(volbar, false, 0, false)
end
