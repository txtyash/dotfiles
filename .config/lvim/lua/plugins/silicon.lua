local M = {}
M.config = function()
  local status_ok, silicon = pcall(require, "silicon")
  if not status_ok then
    return
  end

  silicon.setup({
    font = 'FantasqueSansMono Nerd Font=16',
    theme = 'Monokai Extended',
  })

end
return M
