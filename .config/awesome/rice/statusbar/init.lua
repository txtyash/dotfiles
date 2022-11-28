require "statusbar/widgets"

-- Widget and layout library
local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local battery_widget = require("awesome-wm-widgets.battery-widget.battery")
local volume_widget = require("widgets/volume")

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
  awful.button({}, 1, function(t) t:view_only() end),
  awful.button({ Modkey }, 1, function(t)
    if client.focus then
      client.focus:move_to_tag(t)
    end
  end),
  awful.button({}, 3, awful.tag.viewtoggle),
  awful.button({ Modkey }, 3, function(t)
    if client.focus then
      client.focus:toggle_tag(t)
    end
  end),
  awful.button({}, 4, function(t) awful.tag.viewnext(t.screen) end),
  awful.button({}, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local tasklist_buttons = gears.table.join(
  awful.button({}, 1, function(c)
    if c == client.focus then
      c.minimized = true
    else
      c:emit_signal(
        "request::activate",
        "tasklist",
        { raise = true }
      )
    end
  end),
  awful.button({}, 3, function()
    awful.menu.client_list({ theme = { width = 250 } })
  end),
  awful.button({}, 4, function()
    awful.client.focus.byidx(1)
  end),
  awful.button({}, 5, function()
    awful.client.focus.byidx(-1)
  end))

local function set_wallpaper(s)
  -- Wallpaper
  if beautiful.wallpaper then
    local wallpaper = beautiful.wallpaper
    -- If wallpaper is a function, call it with the screen
    if type(wallpaper) == "function" then
      wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)
  end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

-- Create a textclock widget
local clock = wibox.widget {
  {
    {
      format  = "%H",
      refresh = 1,
      widget  = wibox.widget.textclock,
      align   = "center",
      valign  = "center",
    },
    {
      format  = "%M",
      refresh = 1,
      widget  = wibox.widget.textclock,
      align   = "center",
      valign  = "center",
    },
    layout = wibox.layout.fixed.vertical,
    widget = wibox.container.background,
    fg     = beautiful.white,
  },
  layout = wibox.layout.fixed.vertical,
}

clock = wibox.container.margin(clock, 2, 2, 12, 2)

local date = wibox.widget {
  spacing = 6,
  {
    format = "%d",
    widget = wibox.widget.textclock,
    align  = "center",
    valign = "center",
  },
  {
    font   = "FontAwesome 5 Free Solid:size=12:style=Bold;3",
    markup = '',
    align  = "center",
    valign = "center",
    widget = wibox.widget.textbox
  },
  {
    format = "0%w",
    widget = wibox.widget.textclock,
    align  = "center",
    valign = "center",
  },
  layout = wibox.layout.fixed.vertical,
}

local battery = wibox.widget {
  battery_widget(
    {
      font               = "FontAwesome 5 Free Solid:size=12:style=Bold;3",
      show_current_level = true,
    }
  ),
  layout = wibox.layout.fixed.vertical,
}

-- date = wibox.container.margin(date, 2, 2, 12, 2)

awful.screen.connect_for_each_screen(function(s)
  -- Wallpaper
  set_wallpaper(s)

  -- Each screen has its own tag table.
  awful.tag({ "S", "D", "F", "K", "L" }, s, awful.layout.layouts[1])

  MyLauncher = awful.widget.launcher({ image = "/home/zim/.config/awesome/icons/menu.png",
    menu = MainMenu })

  -- Create a promptbox for each screen
  s.mypromptbox = awful.widget.prompt()
  -- Create an imagebox widget which will contain an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  s.mylayoutbox = awful.widget.layoutbox(s)
  s.mylayoutbox = wibox.container.margin(s.mylayoutbox, 1, 1, 1, 15)
  s.mylayoutbox:buttons(gears.table.join(
    awful.button({}, 1, function() awful.layout.inc(1) end),
    awful.button({}, 3, function() awful.layout.inc(-1) end),
    awful.button({}, 4, function() awful.layout.inc(1) end),
    awful.button({}, 5, function() awful.layout.inc(-1) end)))

  -- Create a taglist widget
  s.mytaglist = awful.widget.taglist {
    screen          = s,
    filter          = awful.widget.taglist.filter.all,
    buttons         = taglist_buttons,
    layout          = {
      spacing = 6,
      layout  = wibox.layout.fixed.vertical,
    },
    widget_template = {
      {
        {
          widget = wibox.widget.textbox,
          id = "text_role",
          align = "center",
          valign = "center",
        },
        margins = 3,
        widget = wibox.container.margin,
      },
      bg = '#dddddd55',
      shape = gears.shape.circle,
      widget = wibox.container.background,
    }
  }

  -- Create a tasklist widget
  s.tasklistmax = awful.widget.tasklist {
    screen          = s,
    filter          = function(c, s)
      if not c.minimized then
        return awful.widget.tasklist.filter.currenttags(c, s)
      end
    end,
    buttons         = tasklist_buttons,
    style           = {
      shape_border_width = 0,
      shape = function(cr, width, height)
        gears.shape.rounded_rect(cr, 24, 4, 2)
      end,
    },
    layout          = {
      spacing = 6,
      layout  = wibox.layout.fixed.vertical,
    },
    widget_template = {
      {
        {
          {
            id = "icon_role",
            widget = wibox.widget.imagebox,
          },
          top = 6,
          widget = wibox.container.margin,
        },
        margins = 0,
        widget = wibox.container.margin,
      },
      id     = 'background_role',
      widget = wibox.container.background,
    }
  }

  s.tasklistmax = wibox.container.margin(s.tasklistmax, 1, 1, 1, 1)

  -- Create a tasklist widget
  s.tasklistmin = awful.widget.tasklist {
    screen          = s,
    filter          = awful.widget.tasklist.filter.minimizedcurrenttags,
    buttons         = tasklist_buttons,
    style           = {
      shape_border_width = 0,
      shape_border_color = '#ffffff00',
      shape              = gears.shape.rounded_rect,
    },
    layout          = {
      spacing = 6,
      layout  = wibox.layout.fixed.vertical,
    },
    widget_template = {
      id = "icon_role",
      widget = wibox.widget.imagebox,
    }
  }

  s.tasklistmin = wibox.container.margin(s.tasklistmin, 1, 1, 1, 1)

  local mysystray = wibox.container {
    wibox.container.margin(wibox.widget.systray(), 1, 1, 1, 1),
    direction = 'east',
    widget    = wibox.container.rotate,
    spacing   = 6,
  }

  -- Create the wibox
  s.mywibox = awful.wibar({ position = "left", screen = s, width = 30 })

  -- Add widgets to the wibox
  s.mywibox:setup {
    layout = wibox.layout.align.vertical,
    { -- Left widgets
      spacing = 12,
      clock,
      battery,
      volume_widget(),
      s.mytaglist,
      s.mypromptbox,
      layout = wibox.layout.fixed.vertical,
    },
    s.tasklistmax, -- Middle widget
    { -- Right widgets
      spacing = 12,
      layout = wibox.layout.fixed.vertical,
      s.tasklistmin,
      mysystray,
      date,
      MyLauncher,
      s.mylayoutbox,
    },
    left = 300, -- TODO
  }

end)
