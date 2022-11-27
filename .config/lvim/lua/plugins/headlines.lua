local M = {}
M.config = function()
  local status_ok, headlines = pcall(require, "headlines")
  if not status_ok then
    return
  end

  headlines.setup()

end
return M
