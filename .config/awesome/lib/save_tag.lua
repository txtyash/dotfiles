local awful = require 'awful'

-- local save_current_tag = function()
--   local f = assert(io.open("/tmp/aw.tag", "w"))
--   local t = client.focus and client.focus.first_tag or nil
--   f:write(t.name, "\n")
--   f:close()
-- end

function LoadLastActiveTag()
  local f = assert(io.open("/tmp/aw.tag", "r"))
  if f ~= nil then
    local tag_name = f:read("*line")
    f:close()
    local t = awful.tag.find_by_name(nil, tag_name)
    if t ~= nil then
      awful.tag.viewnone()
      awful.tag.viewtoggle(t)
    end
  end
end

awesome.connect_signal("exit", function(_)
  -- Persist last tags through exit/restart
  for s in screen do
    local f = io.open("/tmp/aw.tag", "w+")
    local t = s.selected_tag
    if t then
      f:write(t.name, "\n")
    end
    f:close()
  end
end)

-- FROM:
-- https://www.reddit.com/r/awesomewm/comments/p016k7/staying_in_the_current_workspace_after_awesome/
