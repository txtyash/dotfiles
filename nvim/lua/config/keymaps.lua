-- TODO: Map o and O to not go into insert mode
-- BUG: If on buffer A and I open buffer B and close it using the leader-c binding, then buffer C is displayed. It should display the buffer B
-- TODO: map <ctrl-c> in normal mode in telescope pickers to quit telescope
-- TODO: add mapping to insert white space without leaving insert mode
-- TODO: Install extend key objects for conveniences like dac(delete around condition), etc.
local map = vim.keymap.set

-- Tabs
map("n", "<c-j>", "<cmd>tabnext<cr>", { desc = "Next tab" })
map("n", "<c-k>", "<cmd>tabprevious<cr>", { desc = "Previous tab" })

map('n', 'O', "<Cmd>call append(line('.') - 1, repeat([''], v:count1))<CR>")
map('n', 'o', "<Cmd>call append(line('.'),     repeat([''], v:count1))<CR>")

-- Telescope
map({ 'n', 'i' }, '<C-s><C-b>',  "<cmd>Telescope buffers<cr>", { desc = 'Buffers' })
map({ 'n', 'i' }, '<C-s><C-s>',  "<cmd>Telescope builtin<cr>", { desc = 'Telescope pickers' })
map({ 'n', 'i' }, '<C-s><C-f>',  "<cmd>Telescope find_files<cr>", { desc = 'Find Files' })
map({ 'n', 'i' }, '<C-s><C-o>',  "<cmd>Telescope oldfiles<cr>", { desc = 'Old files' })
map({ 'n', 'i' }, '<C-s><C-g>',  "<cmd>Telescope live_grep<cr>", { desc = 'Grep' })

map('n', "<leader>w", "<cmd>w<cr>", { desc = "Write" })
map('n', "<leader>e", "<cmd>lua MiniFiles.open()<cr>", { desc = "File Explorer" })
map('n', "<leader>p",  "<cmd>pwd<cr>", { desc = "pwd" })
map('n', "<leader>c",  "<cmd>terminal<cr>", { desc = "Console" })
map('n', "<leader>z", "<cmd>Telekasten panel<CR>", { desc = "Zettelkasten" })
map('n', "<leader>t", "<cmd>tabnew<CR>", { desc = "New tab" })
map('n', "<leader>q", "<cmd>:q<CR>", { desc = "Quit" })
