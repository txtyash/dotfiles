-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local Util = require("lazyvim.util")
local functions = require("functions")
local map = functions.map

if vim.g.neovide then
  vim.o.guifont = "FiraCode Nerd Font:h13"
  vim.g.neovide_hide_mouse_when_typing = true
  vim.g.neovide_cursor_vfx_mode = "ripple"
  vim.g.neovide_cursor_vfx_opacity = 180.0
  vim.g.neovide_cursor_vfx_particle_density = 39.0
end

local opt = vim.opt

vim.cmd([[ set rnu]])
vim.cmd([[ set shell=/usr/bin/fish]])
vim.cmd([[ set cursorcolumn]])
vim.cmd([[ set autoread]]) -- Run :edit to refresh externally edited files
vim.g.netrw_liststyle = 3

opt.clipboard = "" -- Sync with system clipboard
vim.opt.swapfile = false

vim.cmd([[ command! BaleiaColorize call g:baleia.once(bufnr('%')) ]])
