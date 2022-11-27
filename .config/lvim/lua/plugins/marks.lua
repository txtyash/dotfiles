local M = {}
M.config = function()
  local status_ok, marks = pcall(require, "marks")
  if not status_ok then
    return
  end

  marks.setup({
    default_mappings = true,
    signs = true,
    mappings = {}
  })

end
return M
