local awful = require("awful")
local beautiful = require("beautiful")
local hotkeys_popup = require("awful.hotkeys_popup")
local menubar = require("menubar")

-- Create a launcher widget and a main menu
MyAwesomeMenu = {
  { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
  { "manual", Terminal .. " -e man awesome" },
  { "edit config", Editor_cmd .. " " .. awesome.conffile },
  { "restart", awesome.restart },
  { "quit", function() awesome.quit() end },
}

MainMenu = awful.menu({ items = { { "awesome", MyAwesomeMenu, beautiful.awesome_icon },
  { "open terminal", Terminal }
}
})

MyLauncher = awful.widget.launcher({ image = "/home/zim/.config/awesome/icons/menu.png",
  menu = MainMenu })

-- mylauncher = wibox.container.margin(mylauncher, 1, 1, 1, 1)

-- Menubar configuration
menubar.utils.terminal = Terminal -- Set the terminal for applications that require it
