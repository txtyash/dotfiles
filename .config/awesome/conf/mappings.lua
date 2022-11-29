local awful = require("awful")
local gears = require("gears")
local hotkeys_popup = require("awful.hotkeys_popup")
local volume = require("lib.volume")
local brightness = require("lib.brightness")
local touchpad = require("lib.touchpad")
require("lib.scratchpads")
-- local bling = require("modules.bling")

globalkeys = gears.table.join(
  awful.key({ Modkey, "Shift" }, "Return", hotkeys_popup.show_help,
    { description = "show help", group = "awesome" }),
  awful.key({ Modkey, }, "Left", awful.tag.viewprev,
    { description = "view previous", group = "tag" }),
  awful.key({ Modkey, }, "Right", awful.tag.viewnext,
    { description = "view next", group = "tag" }),
  awful.key({ Modkey, }, "Escape", awful.tag.history.restore,
    { description = "go back", group = "tag" }),

  awful.key({ Modkey, }, "j",
    function()
      awful.client.focus.byidx(1)
    end,
    { description = "focus next by index", group = "client" }
  ),

  awful.key({ Modkey, }, "k",
    function()
      awful.client.focus.byidx(-1)
    end,
    { description = "focus previous by index", group = "client" }
  ),

  awful.key({ Modkey, }, "f",
    function()
      local master = awful.client.getmaster(awful.screen.focused())
      if master then
        master:emit_signal(
          "request::activate", { raise = true }
        )
      end
    end,
    { description = "focus master", group = "client" }
  ),

  -- Function keys

  -- Screenshot keys
  awful.key({}, "Print", function()
    awful.spawn.with_shell("flameshot full -c -p ~/screenshots_full -c")
  end,
    { description = "Full screenshot", group = "hotkeys" }),
  awful.key({ "Shift" }, "Print", function()
    awful.spawn.with_shell("scrotactive")
  end,
    { description = "Window screenshot", group = "hotkeys" }),
  awful.key({ "Control" }, "Print", function()
    awful.spawn.with_shell("flameshot gui -s -c -p ~/screenshots_cutout -c")
  end,
    { description = "Selective screenshot", group = "hotkeys" }),

  -- Volume keys
  awful.key({}, "XF86AudioMute", volume.toggle,
    { description = "Mute/Unmute audio", group = "audio" }),
  awful.key({}, "XF86AudioRaiseVolume", volume.increase,
    { description = "Raise volume", group = "hotkeys" }),
  awful.key({}, "XF86AudioLowerVolume", volume.decrease,
    { description = "Lower volume", group = "hotkeys" }),

  -- Brightness keys
  awful.key({}, "XF86MonBrightnessUp", brightness.increase,
    { description = "Lower volume", group = "hotkeys" }),
  awful.key({}, "XF86MonBrightnessDown", brightness.decrease,
    { description = "Lower brightness", group = "hotkeys" }),
  awful.key({}, "XF86TouchpadToggle", touchpad.toggle,
    { description = "Lower brightness", group = "hotkeys" }),

  -- Layout manipulation
  awful.key({ Modkey, "Shift" }, "j", function() awful.client.swap.byidx(1) end,
    { description = "swap with next client by index", group = "client" }),
  awful.key({ Modkey, "Shift" }, "k", function() awful.client.swap.byidx(-1) end,
    { description = "swap with previous client by index", group = "client" }),
  awful.key({ Modkey, "Control" }, "j", function() awful.screen.focus_relative(1) end,
    { description = "focus the next screen", group = "screen" }),
  awful.key({ Modkey, "Control" }, "k", function() awful.screen.focus_relative(-1) end,
    { description = "focus the previous screen", group = "screen" }),

  -- Spawn!
  awful.key({ Modkey, }, "t", function() awful.spawn(Terminal) end,
    { description = "open a terminal", group = "launcher" }),
  awful.key({ Modkey, }, "b", function() awful.spawn(Browser) end,
    { description = "open a browser", group = "launcher" }),
  -- awful.key({ Modkey, }, "e", function() Scratchy:toggle() end,
  --   { description = "scratchpad", group = "client" }),
  awful.key({ Modkey, }, "r", function()
    awful.spawn.with_shell("rofi -no-lazy-grab -show drun -modi run,drun,window -theme $HOME/.config/rofi/launcher/style -drun-icon-theme \'papirus\' ")
  end,
    { description = "open app launcher", group = "launcher" }),

  -- Standard
  awful.key({ Modkey, }, "q", awesome.restart,
    { description = "reload awesome", group = "awesome" }),
  awful.key({ Modkey, "Shift" }, "q", awesome.quit,
    { description = "quit awesome", group = "awesome" }),

  -- resizing
  awful.key({ Modkey, }, "h", function() awful.tag.incmwfact(0.03) end,
    { description = "increase master width factor", group = "layout" }),
  awful.key({ Modkey, }, "l", function() awful.tag.incmwfact(-0.03) end,
    { description = "decrease master width factor", group = "layout" }),

  awful.key({ Modkey, }, ",", function() awful.tag.incnmaster(1, nil, true) end,
    { description = "increase the number of master clients", group = "layout" }),
  awful.key({ Modkey, }, ".", function() awful.tag.incnmaster(-1, nil, true) end,
    { description = "decrease the number of master clients", group = "layout" }),
  awful.key({ Modkey, "Control" }, "l", function() awful.tag.incncol(1, nil, true) end,
    { description = "increase the number of columns", group = "layout" }),
  awful.key({ Modkey, "Control" }, "h", function() awful.tag.incncol(-1, nil, true) end,
    { description = "decrease the number of columns", group = "layout" }),
  awful.key({ Modkey, }, "space", function() awful.layout.inc(1) end,
    { description = "select next", group = "layout" }),
  awful.key({ Modkey, }, "o",
    function()
      local c = awful.client.restore()
      if c then
        c:emit_signal(
          "request::activate", "key.unminimize", { raise = true }
        )
      end
    end,
    { description = "restore minimized", group = "client" })
)

clientkeys = gears.table.join(
  awful.key({ Modkey }, "m", awful.client.setmaster,
    { description = "Swap window with master", group = "layout" }),
  awful.key({ Modkey, }, "BackSpace", function(c) c:kill() end,
    { description = "close", group = "client" }),
  awful.key({ Modkey, "Shift" }, "f", awful.client.floating.toggle,
    { description = "toggle floating", group = "client" }),
  awful.key({ Modkey, "Control" }, "Return", function(c) c:swap(awful.client.getmaster()) end,
    { description = "move to master", group = "client" }),
  awful.key({ Modkey, }, "i",
    function(c)
      c.minimized = true
    end,
    { description = "minimize", group = "client" })
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
  globalkeys = gears.table.join(globalkeys,
    -- View tag only.
    awful.key({ Modkey }, "#" .. i + 9,
      function()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
          tag:view_only()
        end
      end,
      { description = "view tag #" .. i, group = "tag" }),
    -- Toggle tag display.
    awful.key({ Modkey, "Control" }, "#" .. i + 9,
      function()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
          awful.tag.viewtoggle(tag)
        end
      end,
      { description = "toggle tag #" .. i, group = "tag" }),
    -- Move client to tag.
    awful.key({ Modkey, "Shift" }, "#" .. i + 9,
      function()
        if client.focus then
          local tag = client.focus.screen.tags[i]
          if tag then
            client.focus:move_to_tag(tag)
          end
        end
      end,
      { description = "move focused client to tag #" .. i, group = "tag" }),
    -- Toggle tag on focused client.
    awful.key({ Modkey, "Control", "Shift" }, "#" .. i + 9,
      function()
        if client.focus then
          local tag = client.focus.screen.tags[i]
          if tag then
            client.focus:toggle_tag(tag)
          end
        end
      end,
      { description = "toggle focused client on tag #" .. i, group = "tag" })
  )
end

clientbuttons = gears.table.join(
  awful.button({}, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
  end),
  awful.button({ Modkey }, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
    awful.mouse.client.move(c)
  end),
  awful.button({ Modkey }, 3, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
    awful.mouse.client.resize(c)
  end)
)

-- Set keys
root.keys(globalkeys)

-- Keyboard map indicator and switcher
MyKeyboardLayout = awful.widget.keyboardlayout()

-- Mouse bindings
root.buttons(gears.table.join(
  awful.button({}, 3, function() MainMenu:toggle() end),
  awful.button({}, 4, awful.tag.viewnext),
  awful.button({}, 5, awful.tag.viewprev)
))
