local gfs = require("gears.filesystem")
local beautiful = require("beautiful")

beautiful.init(gfs.get_configuration_dir() .. "themes/" .. Theme .. "/theme.lua")
beautiful.get().wallpaper = (gfs.get_configuration_dir() .. "themes/" .. Theme .. "/wall.png")
