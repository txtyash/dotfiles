local awful = require("awful")

local autostart = {}

local startup_apps = {
  Networking,
  -- Compositor,
  ScreenCapture,
}

for _, app in ipairs(startup_apps) do
  table.insert(autostart, app)
end

for _, app in ipairs(autostart) do
  awful.spawn.with_shell(app)
end
