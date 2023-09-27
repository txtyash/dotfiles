-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

local Util = require("lazyvim.util")
local functions = require("functions")
local map = functions.map
local theme = functions.theme

--
-- -- Custom Keybindings -- --
--
vim.keymap.del("i", "<C-s>")
vim.keymap.del("n", "<C-s>")
vim.keymap.del("v", "<C-s>")

map("n", "<C-i>", "<C-i>") -- Make vim stick to it's default C-i binding

map("n", "o", "o <BS><esc>")
map("n", "O", "O <BS><esc>")

map("n", "<BS><BS>", "<cmd>bd<cr>", { desc = "Close This Buffer" })
map("n", "<BS>h", "<cmd>BufferLineCloseLeft<cr>", { desc = "Close Left Buffers" })
map("n", "<BS>l", "<cmd>BufferLineCloseRight<cr>", { desc = "Close Right Buffers" })
map("n", "<BS>o", "<cmd>BufferLineCloseOthers<cr>", { desc = "Close Other Buffers" })

map("n", "]<space>", "a <esc>h", { desc = "Append Space" })
map("n", "[<space>", "i <esc>l", { desc = "Prepend Space" })

map("n", "<esc>", "<cmd>nohl<cr><esc>", { desc = "No highlight" })

map("n", "]<Tab>", "a    <esc>4h", { desc = "Append Tab" })
map("n", "[<Tab>", "i    <esc>l", { desc = "Prepend Tab" })

map("n", "<C-i>", "<C-i>", { desc = "jumplist" }) -- unmap nvim-cmp's C-i
map("n", "<Leader>t", "<cmd>TableModeToggle<cr>", { desc = "Toggle TableMode" })

map("n", "<M-c>", theme, { desc = "Toggle theme", silent = true })
map("i", "<M-c>", theme, { desc = "Toggle theme", silent = true })

map("i", "<C-z>", "<esc><C-z>", { desc = "suspend" })

map("n", "<C-y>", '"+y', { desc = "Copy to clipboard" })
map("x", "<C-y>", '"+y', { desc = "Copy visual selection to clipboard" })
map({ "v", "i", "n", "s" }, "<C-y><C-y>", "<cmd>w<cr><bar><cmd>!wl-copy < %<cr>", { desc = "Copy entire file" })
map({ "i", "v", "n", "s" }, "<C-s><C-s>", "<cmd>w<cr>", { remap = true, desc = "Save file" })
map({ "i", "v", "n", "s" }, "<C-s>s", "<cmd>w<cr>", { remap = true, desc = "Save file" })
map("i", "<C-l>", "<Esc>lxi", { desc = "Delete ahead" })
map({ "v", "n" }, "gp", '"+p', { desc = "Paste from clipboard" })
map({ "v", "n" }, "gP", '"+P', { desc = "Paste from clipboard" })

map({ "n" }, "<Leader>iy", "<cmd>IconPickerYank<cr>", { desc = "Icon picker" })
map({ "n" }, "<Leader>in", "<cmd>IconPickerNormal<cr>", { desc = "Icon picker" })
map({ "i" }, "<C-s>i", "<cmd>IconPickerInsert<cr><esc>", { remap = true, desc = "Icon picker" })
map({ "v", "i", "n", "s" }, "<C-s>w", function()
  Util.toggle("wrap")
end, { remap = true, desc = "Toggle Word Wrap" })

map("n", "<leader>e", require("oil").open, { desc = "open oil" })
map("n", "<leader>n", "<cmd>Ex<cr>", { desc = "open netrw" })

map("n", "<M-h>", "<cmd>SidewaysLeft<cr>", { desc = "sidewaysleft" })
map("n", "<M-l>", "<cmd>SidewaysRight<cr>", { desc = "sidewaysright" })

vim.cmd([[nnoremap <expr> ^ match(getline('.'), '\S') == col('.') - 1 ? '0' : '^']])

-- map("v", "<C-q>", "<esc>:nohl<cr>", { desc = "Clear highlight" })
-- map("i", "<C-q>", "<esc>:nohl<cr>", { desc = "Clear highlight" })
-- map("n", "<C-q>", "<esc>:nohl<cr>", { desc = "Clear highlight" })
-- map("s", "<C-q>", "<esc>:nohl<cr>", { desc = "Clear highlight" })
