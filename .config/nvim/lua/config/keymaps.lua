-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

local functions = require("functions")
local map = functions.map
local theme = functions.theme

--
-- -- Custom Keybindings -- --
--
map("n", "<C-i>", "<C-i>") -- Make vim stick to it's default C-i binding

map("n", "o", "o <BS><esc>")
map("n", "O", "O <BS><esc>")

map("n", "x", "<cmd>bd<cr>")

map("n", "]<space>", "a <esc>h", { desc = "Append Space" })
map("n", "[<space>", "i <esc>l", { desc = "Prepend Space" })

map("n", "<esc>", "<esc>:nohl<cr>", { desc = "No highlight" })

map("n", "]<Tab>", "a    <esc>4h", { desc = "Append Tab" })
map("n", "[<Tab>", "i    <esc>l", { desc = "Prepend Tab" })

map("n", "<C-i>", "<C-i>", { desc = "jumplist" }) -- unmap nvim-cmp's C-i
map("n", "<space>e", "<cmd>Ex<cr>", { desc = "netrw" })
map("n", "<space>t", "<cmd>TableModeToggle<cr>", { desc = "Toggle TableMode" })

map("n", "<M-c>", theme, { desc = "Toggle theme", silent = true })
map("i", "<M-c>", theme, { desc = "Toggle theme", silent = true })

map("n", "<C-y>", '"+y', { desc = "Copy to clipboard" })
map("x", "<C-y>", '"+y', { desc = "Copy visual selection to clipboard" })
map({ "v", "i", "n", "s" }, "<C-y><C-y>", "<cmd>w<cr><bar><cmd>!wl-copy < %<cr>", { desc = "Copy entire file" })
map({ "i", "v", "n", "s" }, "<C-s><C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })
map({ "i", "v", "n", "s" }, "<C-s>s", "<cmd>w<cr><esc>", { desc = "Save file" })
map("i", "<C-l>", "<Esc>lxi", { desc = "Delete ahead" })
map({ "v", "n" }, "gp", '"+p', { desc = "Paste from clipboard" })
map({ "v", "n" }, "gP", '"+P', { desc = "Paste from clipboard" })

vim.cmd([[nnoremap <expr> ^ match(getline('.'), '\S') == col('.') - 1 ? '0' : '^']])

-- map("v", "<C-q>", "<esc>:nohl<cr>", { desc = "Clear highlight" })
-- map("i", "<C-q>", "<esc>:nohl<cr>", { desc = "Clear highlight" })
-- map("n", "<C-q>", "<esc>:nohl<cr>", { desc = "Clear highlight" })
-- map("s", "<C-q>", "<esc>:nohl<cr>", { desc = "Clear highlight" })
