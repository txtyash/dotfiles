-- Use `:help` to learn about these options
-- TODO: Listchars
-- TODO: tabout
-- TODO: preserve folds throught sessions

vim.cmd("cd " .. vim.fn.getcwd())
vim.cmd("colorscheme kanagawa")
vim.cmd("set completeopt+=noselect")
vim.opt.wrap = false
vim.opt.scrolloff = 3
vim.opt.ignorecase = true
vim.opt.cursorcolumn = true
vim.opt.cursorline = true
vim.opt.smartcase = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.guifont = "JetBrainsMono_Nerd_Font:h11"
vim.opt.shell = '/usr/bin/fish'

vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

-- Window padding for GUI client Neovide
if vim.g.neovide then
  vim.g.neovide_padding_top = 3
  vim.g.neovide_padding_bottom = 3
  vim.g.neovide_padding_right = 3
  vim.g.neovide_padding_left = 3
end
