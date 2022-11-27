local awful = require "awful"

local touchpad = {}

touchpad.toggle = function()
  local script = [[
  toggle_touchpad
	]]

  awful.spawn.with_shell(script)
end

return touchpad
