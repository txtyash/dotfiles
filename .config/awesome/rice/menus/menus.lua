-- TODO: temporary variables
local terminal = "alacritty"
local editor = "lvim"
local editor_cmd = terminal .. " -e " .. editor

local awful = require("awful")
local beautiful = require("beautiful")
local hotkeys_popup = require("awful.hotkeys_popup")
local menubar = require("menubar")

-- Create a launcher widget and a main menu
MyAwesomeMenu = {
  { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
  { "manual", terminal .. " -e man awesome" },
  { "edit config", editor_cmd .. " " .. awesome.conffile },
  { "restart", awesome.restart },
  { "quit", function() awesome.quit() end },
}

MainMenu = awful.menu({ items = { { "awesome", MyAwesomeMenu, beautiful.awesome_icon },
  { "open terminal", terminal }
}
})

MyLauncher = awful.widget.launcher({ image = "/home/zim/.config/awesome/icons/menu.png",
  menu = MainMenu })

-- mylauncher = wibox.container.margin(mylauncher, 1, 1, 1, 1)

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
