-- TODO: Map o and O to not go into insert mode
-- BUG: If on buffer A and I open buffer B and close it using the leader-c binding, then buffer C is displayed. It should display the buffer B
-- TODO: map <ctrl-c> in normal mode in telescope pickers to quit telescope
-- TODO: add mapping to insert white space without leaving insert mode
-- TODO: Install extend key objects for conveniences like dac(delete around condition), etc.
local map = vim.keymap.set

-- Tabs
map("n", "<c-j>", "<cmd>tabnext<cr>", { desc = "Next tab" })
map("n", "<c-k>", "<cmd>tabprevious<cr>", { desc = "Previous tab" })
