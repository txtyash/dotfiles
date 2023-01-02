require "rice/menus/menus"

local gfs = require("gears.filesystem")
local dir = gfs.get_configuration_dir()
local mouse = mouse

local bling = require 'modules.bling'

-- require(dir .. "widgets")

-- Widget and layout library
local awful = require 'awful'
local gears = require 'gears'
local wibox = require 'wibox'
local beautiful = require 'beautiful'
local volume_widget = require 'rice.statusbar.widgets.volume'
local battery_widget = require 'rice.statusbar.widgets.battery'

TaglistButtons = gears.table.join(
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

TasklistButtons = gears.table.join(
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
    -- fg     = beautiful.black,
  },
  layout = wibox.layout.fixed.vertical,
}

clock = wibox.container.margin(clock, 2, 2, 2, 2)

-- Formatted = function()
--   -- s:sub(1, 2)
-- end

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
    id     = "day",
    format = "%W",
    widget = wibox.widget.textclock,
    align  = "center",
    valign = "center",
  },
  layout = wibox.layout.fixed.vertical,
}

local day = date.day
day:set_markup_silently(string.lower(day.markup:sub(2, 3)))

-- date = wibox.container.margin(date, 2, 2, 12, 2)

local battery = wibox.widget {
  battery_widget(
    {
      font               = beautiful.font,
      size               = 24,
      show_current_level = true,
      arc_thickness      = 2,
    }
  ),
  layout = wibox.layout.fixed.vertical,
}

-- bling.widget.tag_preview.enable {
--   show_client_content = true, -- Whether or not to show the client content
--   scale = 0.5, -- The scale of the previews compared to the screen
--   honor_padding = true, -- Honor padding when creating widget size
--   honor_workarea = true, -- Honor work area when creating widget size
--   placement_fn = function(c) -- Place the widget using awful.placement (this overrides x & y)
--     awful.placement.centered(c)
--   end,
--   background_widget = wibox.widget { -- Set a background image (like a wallpaper) for the widget
--     image                 = beautiful.wallpaper,
--     horizontal_fit_policy = "fit",
--     vertical_fit_policy   = "fit",
--     widget                = wibox.widget.imagebox
--   }
-- }

awful.screen.connect_for_each_screen(function(s)

  -- Keyboard map indicator and switcher
  -- MyKeyboardLayout = awful.widget.keyboardlayout()

  MyLauncher = wibox.container.margin(MyLauncher, 2, 2, 12, 2)

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
    buttons         = TaglistButtons,
    style           = {
      shape = gears.shape.circle,
    },
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
      id = "background_role",
      widget = wibox.container.background,
      -- create_callback = function(self, c3, index, objects) --luacheck: no unused args
      --   self:get_children_by_id('text_role')[1].markup = '<b> ' .. index .. ' </b>'
      --   self:connect_signal('mouse::enter', function()

      --     -- BLING: Only show widget when there are clients in the tag
      --     if #c3:clients() > 0 then
      --       -- BLING: Update the widget with the new tag
      --       awesome.emit_signal("bling::tag_preview::update", c3)
      --       -- BLING: Show the widget
      --       awesome.emit_signal("bling::tag_preview::visibility", s, true)
      --     end

      --     if self.bg ~= '#ff0000' then
      --       self.backup     = self.bg
      --       self.has_backup = true
      --     end
      --     self.bg = '#ff0000'
      --   end)
      --   self:connect_signal('mouse::leave', function()

      --     -- BLING: Turn the widget off
      --     awesome.emit_signal("bling::tag_preview::visibility", s, false)

      --     if self.has_backup then self.bg = self.backup end
      --   end)
      -- end,
      -- update_callback = function(self, c3, index, objects) --luacheck: no unused args
      --   self:get_children_by_id('text_role')[1].markup = '<b> ' .. index .. ' </b>'
      -- end,
    },
  }

  -- Create a tasklist widget
  s.tasklistmax = awful.widget.tasklist {
    screen          = s,
    filter          = function(c, s)
      if not c.minimized then
        return awful.widget.tasklist.filter.currenttags(c, s)
      end
    end,
    buttons         = TasklistButtons,
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
    buttons         = TasklistButtons,
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

  s.tasklistmin = wibox.container.margin(s.tasklistmin, 3, 3, 2, 2)

  local tray = wibox.container {
    wibox.container.margin(wibox.widget.systray(), 2, 2, 2, 2),
    direction = 'east',
    widget    = wibox.container.rotate,
  }

  -- Create the wibox
  s.statusbar = awful.wibar({ position = "left", screen = s, width = 30 })

  -- Add widgets to the wibox
  s.statusbar:setup {
    layout = wibox.layout.align.vertical,
    { -- Left widgets
      spacing = 12,
      MyLauncher,
      clock,
      s.mytaglist,
      s.mypromptbox,
      layout = wibox.layout.fixed.vertical,
    },
    s.tasklistmax, -- Middle widget
    { -- Right widgets
      spacing = 12,
      layout = wibox.layout.fixed.vertical,
      s.tasklistmin,
      volume_widget(),
      battery,
      tray,
      date,
      s.mylayoutbox,
    },
    left = 300, -- TODO
  }

end)
