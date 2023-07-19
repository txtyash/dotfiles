local function theme()
  if vim.o.background == "light" then
    vim.opt.bg = "dark"
    -- vim.cmd([[  silent !alacritty-toggle d ]])
  else
    vim.opt.bg = "light"
    -- vim.cmd([[  silent !alacritty-toggle l ]])
  end
end

local function map(modes, lhs, rhs, opts)
  if type(modes) == "string" then
    modes = { modes }
  end
  local keys = require("lazy.core.handler").handlers.keys
  for _, mode in pairs(modes) do
    if not keys.active[keys.parse({ lhs, mode = mode }).id] then
      opts = opts or {}
      opts.silent = opts.silent ~= false
      vim.keymap.set(mode, lhs, rhs, opts)
    end
  end
end

return { map = map, theme = theme }
