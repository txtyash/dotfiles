function Theme()
  if vim.o.background == "light" then
    vim.opt.bg = "dark"
    vim.cmd [[  !gela d ]]
  else
    vim.opt.bg = "light"
    vim.cmd [[  !gela l ]]
  end
end
