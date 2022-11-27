local awful = require "awful"

local volume = {}

volume.increase = function()
  local script = [[
   amixer set Master 3%+
	]]

  awful.spawn.with_shell(script)
end

volume.toggle = function()
  local script = [[
 amixer set Master toggle
	]]

  awful.spawn.with_shell(script)
end

volume.decrease = function()
  local script = [[
   amixer set Master 3%-
	]]

  awful.spawn.with_shell(script)
end

return volume
