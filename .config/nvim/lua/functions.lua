local function theme()
  if vim.o.background == "light" then
    vim.opt.bg = "dark"
    vim.cmd([[  silent !gela d ]])
  else
    vim.opt.bg = "light"
    vim.cmd([[  silent !gela l ]])
  end
end

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

return { map = map, theme = theme }
