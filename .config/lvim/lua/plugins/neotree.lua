local M = {}
M.config = function()
  local status_ok, neotree = pcall(require, "neo-tree")
  if not status_ok then
    return
  end

  neotree.setup({
    window = {
      position = "right",
      width = 36,
    },
  })

end
return M
