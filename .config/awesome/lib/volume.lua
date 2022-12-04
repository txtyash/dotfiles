local awful = require "awful"

local volume = {}

volume.increase = function()
  local script = [[
   pamixer -i 3
	]]

  awful.spawn.with_shell(script)
end

volume.toggle = function()
  awful.spawn.easy_async_with_shell("pamixer --toggle-mute", function()
    Icon_update()
  end)


  awful.spawn.with_shell(script)
end

volume.decrease = function()
  local script = [[
   pamixer -d 3
	]]

  awful.spawn.with_shell(script)
end

return volume
