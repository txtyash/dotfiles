-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

vim.cmd([[ set rnu]])
vim.cmd([[ set autoread]]) -- Run :edit to refresh externally edited files

opt.clipboard = "" -- Sync with system clipboard
vim.opt.swapfile = false
