-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

local Util = require("lazyvim.util")
local functions = require("functions")
local map = functions.map
local theme = functions.theme

vim.keymap.del("n", "<C-h>")
vim.keymap.del("n", "<C-j>")
vim.keymap.del("n", "<C-k>")
vim.keymap.del("n", "<C-l>")
vim.keymap.del("n", "<A-j>")
vim.keymap.del("n", "<A-k>")
vim.keymap.del("n", "<Space>ww")
vim.keymap.del("n", "<Space>wd")
vim.keymap.del("n", "<Space>w-")
vim.keymap.del("n", "<Space>w|")

-- NEOVIDE bindings
if vim.g.neovide then
  map({ "n", "i" }, "<C-z>", function()
    Util.float_term()
  end, { desc = "Terminal (cwd)" })
  map({ "v", "n" }, "<M-p>", '"+p', { desc = "Paste from clipboard" })
end

-- WARNING: These Change default bindings 💀

map("n", "+", "a<space><esc>", { desc = "Append Space" })
map("n", "-", "i<space><esc>", { desc = "Prepend Space" })

map("n", "o", "o <BS><esc>")
map("n", "O", "O <BS><esc>")

---------------------------------------------------------------

map("i", "<C-l>", "<Right>", { desc = "move one character right" })
map("i", "<C-h>", "<Left>", { desc = "move one character right" })

map("n", "<leader>w", "<cmd>set wrap!<cr>", { desc = "Toggle Wrap" })

map({ "n", "v" }, "<leader>y", '"+y', { desc = "yank to clipboard" })
map({ "n", "v" }, "<leader>p", '"+p', { desc = "paste from clipboard" })
map({ "n", "v" }, "<leader>P", '"+P', { desc = "paste from clipboard" })

map({ "n", "i" }, "<M-c>", theme, { desc = "Toggle theme", silent = true })

map({ "n" }, "<Leader>I", "<cmd>IconPickerYank<cr>", { desc = "Icon Yanker" })
map({ "n" }, "<Leader>i", "<cmd>IconPickerNormal<cr>", { desc = "Icon Picker" })

map("n", "<leader>e", require("oil").open, { desc = "open oil" })
map("n", "<leader>n", "<cmd>Ex<cr>", { desc = "open netrw" })

-- C-j & C-k moves lines up & down
map("n", "<C-h>", "<cmd>SidewaysLeft<cr>", { desc = "sidewaysleft" })
map("n", "<C-l>", "<cmd>SidewaysRight<cr>", { desc = "sidewaysright" })

-- Move Lines
map("n", "<C-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<C-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("i", "<C-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("i", "<C-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "<C-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<C-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- ^ once = ^ & ^ once again = 0
vim.cmd([[nnoremap <expr> ^ match(getline('.'), '\S') == col('.') - 1 ? '0' : '^']])
