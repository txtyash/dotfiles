vim.cmd("cd " .. vim.fn.getcwd())
vim.cmd("set completeopt+=noselect")
vim.opt.wrap = false
vim.opt.scrolloff = 3
vim.opt.ignorecase = true
vim.opt.cursorcolumn = true
vim.opt.cursorline = true
vim.opt.smartcase = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.guifont = "JetBrainsMono_Nerd_Font:h12"
vim.opt.shell = 'fish'

vim.cmd("colorscheme zenbones")

vim.opt.autoindent = true    -- Copy indent from current line when starting a new one
vim.opt.smartindent = true   -- Insert indents automatically in some cases
vim.opt.expandtab = true -- Convert tabs to spaces
vim.opt.shiftwidth = 4 -- Use 4 spaces for indent
vim.opt.tabstop = 4 -- Render tabs as 4 spaces

-- Window padding for GUI client Neovide
if vim.g.neovide then
  vim.g.neovide_padding_top = 3
  vim.g.neovide_padding_bottom = 3
  vim.g.neovide_padding_right = 3
  vim.g.neovide_padding_left = 3
end
