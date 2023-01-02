local alttab = {}

local cairo = require 'lgi'.cairo
local mouse = mouse
local screen = screen
local wibox = require 'wibox'
local table = table
local gears = require 'gears'
local keygrabber = keygrabber
local math = require 'math'
local awful = require 'awful'
local beautiful = require 'beautiful'
local client = client
awful.client = require 'awful.client'

local settings = {
  preview_box = {
    use = false,
    depict_positions = true,
    delay = 150,
    bg = beautiful.smoked_glass,
    desktop_bg_color = "#00ffff33",
    border = "#22222200",
    border_width = 0,
    fps = 24,
    tint_unselected = 0, -- number in the range [0, 1]: 0 = do not tint; 1 = full black
    text = {
      color = "#779999ff",
      selected_color = "#00ffffff",
      box_height = 60,
      font_size = 21,
    },
  },
  set_opacity = false,
  opacity = 0.5,
}

local function draw_glow(cr, x, y, w, h, r, g, b, a, rad)
  if a == 0 or rad == 0 then
    return
  end
  local glow = cairo.Pattern.create_mesh()
  local function set_colors()
    glow:set_corner_color_rgba(0, r, g, b, a)
    glow:set_corner_color_rgba(1, r, g, b, 0)
    glow:set_corner_color_rgba(2, r, g, b, 0)
    glow:set_corner_color_rgba(3, r, g, b, a)
  end

  local function draw_side(x1, y1, x2, y2, x3, y3, x4, y4)
    glow:begin_patch()
    glow:move_to(x1, y1)
    glow:line_to(x2, y2)
    glow:line_to(x3, y3)
    glow:line_to(x4, y4)
    glow:line_to(x1, y1)
    set_colors()
    glow:end_patch()
  end

  draw_side(x, y, x - rad, y - rad, x - rad, y + h + rad, x, y + h) -- left
  draw_side(x, y, x - rad, y - rad, x + w + rad, y - rad, x + w, y) -- top
  draw_side(x + w, y, x + w + rad, y - rad, x + w + rad, y + h + rad, x + w, y + h) -- right
  draw_side(x + w, y + h, x + w + rad, y + h + rad, x - rad, y + h + rad, x, y + h) -- bottom
  cr:set_source(glow)
  cr:paint()
end

-- A wrapper that ignores :stop() calls in already-stopped timers.
local function timer(args)
  local t = gears.timer(args)
  local started = false
  return {
    start = function()
      started = true
      return t:start()
    end,
    stop = function()
      if not started then return end
      started = false
      return t:stop()
    end,
    connect_signal = function(_, s, f)
      return t:connect_signal(s, f)
    end
  }
end

local current_client

local function raise(c)
  c.minimized = false
  c:raise()
  c.first_tag:view_only()
  client.focus = c
  current_client = c
  return c
end

local alttabbing = false

-- Full history of all clients:
local history
history = {
  log = {},
  add = function(c, force)
    if alttabbing and force ~= "force" then return end
    history.delete(c, force)
    table.insert(history.log, 1, c)
  end,
  delete = function(c, force)
    if alttabbing and force ~= "force" then return end
    for i, v in ipairs(history.log) do
      if v == c then
        table.remove(history.log, i)
        return
      end
    end
  end,
}
setmetatable(history.log, { __mode = "v" })
client.connect_signal("focus", history.add)
client.connect_signal("unmanage", history.delete)
client.connect_signal("minimize", history.delete)

local preview_live_timer = timer({ timeout = 1 / settings.preview_box.fps })

local function restore_order(alttab_table)
  for i = #alttab_table, 1, -1 do
    if not alttab_table[i].minimized then
      alttab_table[i].client:raise()
    else
      alttab_table[i].client.minimized = true
    end
  end
end

local function restore_opacity(alttab_table)
  if settings.set_opacity then
    for i = 1, #alttab_table do
      alttab_table[i].client.opacity = alttab_table[i].opacixlate_y
    end
  end
end

-- Switch to next client, wrapping around if needed
local function cycle(alttab_table, alttab_index, dir)

  restore_order(alttab_table)

  alttab_table[alttab_index].client.minimized = alttab_table[alttab_index].minimized

  alttab_index = alttab_index + dir
  if alttab_index > #alttab_table then
    alttab_index = 1
  elseif alttab_index < 1 then
    alttab_index = #alttab_table
  end

  alttab_table[alttab_index].client.minimized = false

  raise(alttab_table[alttab_index].client)

  return alttab_index
end

local function configure_preview_wbox(preview_wbox, wibox_width, wibox_height)
  -- Apply settings
  preview_wbox:set_bg(settings.preview_box.bg)
  preview_wbox.border_color = settings.preview_box.border

  local x = screen[mouse.screen].geometry.x - preview_wbox.border_width
  local y = screen[mouse.screen].geometry.y + (screen[mouse.screen].geometry.height - wibox_height) / 2
  preview_wbox:geometry({ x = x, y = y, width = wibox_width, height = wibox_height })
end

-- create a list that holds the clients to preview, from left to right
local function create_client_list(alttab_table)
  local leftright_tab = {}
  local n_left
  local n_right
  if #alttab_table == 2 then
    n_left = 0
    n_right = 2
  else
    n_left = math.floor(#alttab_table / 2) - 1
    n_right = math.ceil(#alttab_table / 2) + 1
  end

  for i = 1, n_left do
    table.insert(leftright_tab, alttab_table[#alttab_table - n_left + i])
  end
  for i = 1, n_right do
    table.insert(leftright_tab, alttab_table[i])
  end
  return leftright_tab
end

local function get_title(c, max_len)
  local title = c.name
  if max_len and (#title + 1) > max_len then
    local half = math.floor(max_len / 2)
    title = " " .. title:sub(1, half) .. "…" .. title:sub(-half)
  else
    title = " " .. title
  end
  return title
end

local function set_color(cr, color)
  local r, g, b, a = color:match("#(..)(..)(..)(..)")
  if r then
    r, g, b, a = tonumber(r, 16) / 255, tonumber(g, 16) / 255, tonumber(b, 16) / 255, tonumber(a, 16) / 255
  else
    r, g, b, a = 0, 0, 0, 1
  end
  cr:set_source_rgba(r, g, b, a)
end

local function draw_icon_and_title(cr, c, w, h, text_color)
  -- Icons
  local icon
  local iconbox_width
  local textbox_height = settings.preview_box.text.box_height
  if c.icon then
    icon = gears.surface(c.icon)
    iconbox_width = 0.9 * textbox_height
  else
    iconbox_width = 0
  end
  local iconbox_height = iconbox_width

  -- Titles
  cr:select_font_face("Lode Sans", "sans", "regular", "normal")
  cr:set_font_face(cr:get_font_face())
  cr:set_font_size(settings.preview_box.text.font_size)

  local text, text_width, text_height, titlebox_width, len
  repeat
    text = get_title(c, len)
    text_width = cr:text_extents(text).width
    text_height = cr:text_extents(text).height
    titlebox_width = text_width + iconbox_width
    len = (len or #text) - 1
  until (titlebox_width) <= (w * 0.95)

  local xlate_x = (w - titlebox_width) / 2
  local xlate_y = h

  -- Draw icons
  if icon then
    local scale_x = iconbox_width / icon.width
    local scale_y = iconbox_height / icon.height

    cr:save()
    cr:translate(xlate_x, xlate_y)
    cr:scale(scale_x, scale_y)
    cr:set_source_surface(icon, 0, 0)
    cr:paint()
    cr:restore()
  end

  -- Draw titles
  xlate_x = xlate_x + iconbox_width
  xlate_y = h + (textbox_height + (text_height * 0.5)) / 2

  set_color(cr, text_color)

  cr:move_to(xlate_x, xlate_y)
  cr:show_text(text)
  cr:stroke()
end

local thumbnail_surfaces = {}
local function finish_thumbnail_surfaces()
  for k, surf in pairs(thumbnail_surfaces) do
    surf:finish()
    thumbnail_surfaces[k] = nil
  end
end

local function draw_preview(cr, c, w, h, a, tint, glow)

  if c.minimized and not thumbnail_surfaces[c] then
    return
  end

  local cg = c:geometry()
  local scale_x, scale_y
  if cg.width > cg.height then
    scale_x = a * w / cg.width
    scale_y = math.min(scale_x, a * h / cg.height)
  else
    scale_y = a * h / cg.height
    scale_x = math.min(scale_y, a * h / cg.width)
  end

  local screen_w = c.screen.geometry.width
  local screen_h = c.screen.geometry.height

  local screen_scale_x, screen_scale_y
  if screen_w > screen_h then
    screen_scale_x = a * w / screen_w
    screen_scale_y = math.min(screen_scale_x, a * h / screen_h)
  else
    screen_scale_y = a * h / screen_h
    screen_scale_x = math.min(screen_scale_y, a * w / screen_w)
  end
  local screen_xlate_x = (w - screen_scale_x * screen_w) / 2
  local screen_xlate_y = (h - screen_scale_y * screen_h) / 2

  local rect = {
    x = screen_xlate_x,
    y = screen_xlate_y,
    w = screen_scale_x * screen_w,
    h = screen_scale_y * screen_h,
  }

  local xlate_x, xlate_y
  if settings.preview_box.depict_positions then

    scale_x = screen_scale_x
    scale_y = screen_scale_y

    xlate_x = (w - scale_x * screen_w) / 2 + (scale_x * (cg.x - c.screen.geometry.x))
    xlate_y = (h - scale_y * screen_h) / 2 + (scale_y * (cg.y - c.screen.geometry.y))

    if settings.preview_box.draw_desktop then
      cr:save()
      cr:translate(screen_xlate_x, screen_xlate_y)
      cr:scale(screen_scale_x, screen_scale_y)
      local tmp = gears.surface(root.wallpaper())
      cr:set_source_surface(tmp, 0, 0)
      cr:paint()
      cr:restore()
    else
      set_color(cr, settings.preview_box.desktop_bg_color)
      cr:rectangle(rect.x, rect.y, rect.w, rect.h)
      cr:fill()
    end
    draw_glow(cr, rect.x, rect.y, rect.w, rect.h, 1, 1, 1, 0.2 * glow, 10 * glow)
  else
    xlate_x = (w - scale_x * cg.width) / 2
    xlate_y = (h - scale_y * cg.height) / 2
  end

  cr:save()
  cr:rectangle(rect.x, rect.y, rect.w, rect.h)
  cr:clip()

  cr:save()
  local thumb_surf = thumbnail_surfaces[c]
  if not c.minimized then
    if thumb_surf then thumb_surf:finish() end
    thumb_surf = gears.surface(c.content)
    thumbnail_surfaces[c] = thumb_surf
  end
  cr:translate(xlate_x, xlate_y)
  cr:scale(scale_x, scale_y)
  cr:set_source_surface(thumb_surf, 0, 0)
  cr:paint()
  cr:restore()

  if settings.preview_box.tint_unselected ~= 0 then
    cr:set_source_rgba(0, 0, 0, tint)
    cr:rectangle(xlate_x, xlate_y, scale_x * cg.width, scale_y * cg.height)
    cr:fill()
  end

  draw_glow(cr, xlate_x, xlate_y, scale_x * cg.width, scale_y * cg.height, 0, 1, 1, 0.4 * glow, 10 * glow)

  cr:restore()

end

-- create all the thumbnails
local function create_preview_thumbnails(leftright_tab, w, h)

  local easing_vars = setmetatable({}, { __mode = "k" })
  local function ease(var, c, value)
    local vars = easing_vars[c]
    if not vars then
      easing_vars[c] = {
        [var] = value
      }
      return value
    elseif not vars[var] or (math.abs(vars[var] - value) < math.max(vars[var], value) * 0.01) then
      vars[var] = value
      return value
    else
      value = vars[var] - ((vars[var] - value) * 0.5)
      vars[var] = value
      return value
    end
  end

  local preview_thumbnails = {}
  for i = 1, #leftright_tab do
    preview_thumbnails[i] = wibox.widget.base.make_widget()
    preview_thumbnails[i].fit = function()
      return w, h
    end

    local c = leftright_tab[i].client
    local last_state
    local scale, tint, text_color, glow, opacity
    preview_thumbnails[i].draw = function(_, _, cr, width, height)
      if width == 0 or height == 0 then
        return
      end
      if settings.set_opacity then
        c.opacity = opacity
      end
      draw_icon_and_title(cr, c, w, h, text_color)
      preview_thumbnails[i].thumb_surface = draw_preview(cr, c, w, h, scale, tint, glow,
        preview_thumbnails[i].thumb_surface)
    end

    leftright_tab[i].check_client = function()
      if c == current_client then
        scale = ease("scale", c, 0.9)
        tint = ease("tint", c, 0)
        text_color = settings.preview_box.text.selected_color
        glow = ease("glow", c, 1)
        opacity = ease("opacity", c, 1)
      else
        scale = ease("scale", c, 0.7)
        tint = ease("tint", c, settings.preview_box.tint_unselected)
        text_color = settings.preview_box.text.color
        glow = ease("glow", c, 0)
        opacity = ease("opacity", c, settings.opacity)
      end
      local state = scale
      if state ~= last_state then
        last_state = state
        preview_thumbnails[i]:emit_signal("widget::updated")
      end
    end

    leftright_tab[i].check_client()
  end

  preview_live_timer:connect_signal("timeout", function()
    for i = 1, #leftright_tab do
      leftright_tab[i].check_client()
    end
  end)

  return preview_thumbnails
end

-- Create a wibox to contain all the client-thumbnails
local preview_wbox = wibox({ width = screen[mouse.screen].geometry.width })
preview_wbox.border_width = settings.preview_box.border_width
preview_wbox.ontop = true
preview_wbox.visible = false

local function preview(alttab_table)
  if not settings.preview_box.use then return end

  -- Make the wibox the right size, based on the number of clients
  local wibox_width = screen[mouse.screen].geometry.width + 2 * settings.preview_box.border_width
  local w = wibox_width / math.max(7, #alttab_table) -- thumbnail width
  local h = w * 0.75 -- thumbnail height
  local wibox_height = h + settings.preview_box.text.box_height

  local leftright_tab = create_client_list(alttab_table)
  configure_preview_wbox(preview_wbox, wibox_width, wibox_height)

  local preview_thumbnails = create_preview_thumbnails(leftright_tab, w, h)

  -- Spacers left and right
  local spacer = wibox.widget.base.make_widget()
  spacer.fit = function()
    return (wibox_width - w * #alttab_table) / 2, preview_wbox.height
  end
  spacer.draw = function() end

  --layout
  local preview_layout = wibox.layout.fixed.horizontal()

  preview_layout:add(spacer)
  for i = 1, #leftright_tab do
    preview_layout:add(preview_thumbnails[i])
  end
  preview_layout:add(spacer)

  preview_wbox:set_widget(preview_layout)

end

-- Minimized clients will not appear in the focus history
-- Find them by cycling through all clients, and adding them to the list
-- if not already there.
-- This will preserve the history AND enable you to focus on minimized clients
local function add_minimized_clients(alttab_table)
  for s = 1, screen.count() do
    local t = screen[s].selected_tag
    local all = client.get(s)
    for i = 1, #all do
      local c = all[i]
      local ctags = c:tags()
      -- check if the client is on the current tag
      local is_current_tag = false
      for j = 1, #ctags do
        if t == ctags[j] then
          is_current_tag = true
          break
        end
      end
      if is_current_tag then
        -- check if client is already in the history
        local add_to_table = true
        for k = 1, #alttab_table do
          if alttab_table[k] and alttab_table[k].client == c then
            add_to_table = false
            break
          end
        end
        if add_to_table then
          table.insert(alttab_table, {
            client = c,
            minimized = c.minimized,
            opacity = c.opacity,
          })
        end
      end
    end
  end
end

function alttab.switch(dir, alt, tab, shift_tab)

  alttabbing = true

  local alttab_table = {}
  local alttab_index = 1
  -- for i = 1, #history.log do
  --   local c = history.log[i]
  --   alttab_table[i] = {
  --     client = c,
  --     minimized = c.minimized,
  --     opacity = c.opacity,
  --   }
  -- end

  for _, c in ipairs(mouse.screen.selected_tag:clients()) do
    if c.minimized then
      table.insert(alttab_table, {
        client = c,
        minimized = c.minimized,
        opacity = c.opacity,
      })
    end
  end

  -- add_minimized_clients(alttab_table)

  if #alttab_table == 0 then
    alttabbing = false
    return
  elseif #alttab_table == 1 then
    raise(alttab_table[1].client)
    current_client = nil
    alttabbing = false
    return
  end

  local preview_delay = settings.preview_box.delay / 1000
  local preview_delay_timer = timer({ timeout = preview_delay })
  preview_delay_timer:connect_signal("timeout", function()
    preview_wbox.visible = true
    preview_delay_timer:stop()
    preview(alttab_table)
  end)
  preview_live_timer:start()
  preview_delay_timer:start()

  -- Now that we have collected all windows, we should run a keygrabber
  -- as long as the user is alt-tabbing:
  keygrabber.run(
    function(mod, key, event)
      -- Stop alt-tabbing when the alt-key is released
      if key == alt or key == "Escape" and event == "release" then
        preview_wbox.visible = false

        preview_live_timer:stop()
        preview_delay_timer:stop()

        finish_thumbnail_surfaces()

        restore_order(alttab_table)

        restore_opacity(alttab_table)

        if key == "Escape" then
          raise(alttab_table[1].client)
          keygrabber.stop()
          alttabbing = false
          return
        end

        -- raise chosen client on top of all
        history.add(raise(alttab_table[alttab_index].client), "force")

        current_client = nil
        alttabbing = false

        keygrabber.stop()

      elseif key == "BackSpace" and event == "press" then
        alttab_table[alttab_index].client:kill()
        keygrabber.stop()

        -- Move to previous client on Shift-Tab
      elseif key == shift_tab and event == "press" then
        alttab_index = cycle(alttab_table, alttab_index, -1)

        -- Move to next client on each Tab-press
      elseif key == tab and event == "press" then
        alttab_index = cycle(alttab_table, alttab_index, 1)

      end
    end
  )

  -- switch to next client
  alttab_index = cycle(alttab_table, alttab_index, dir)

end

return alttab
