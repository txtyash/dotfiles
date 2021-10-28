-----------------------------------------------------------
-- Keymaps configuration file: keymaps of neovim
-- and plugins.
-----------------------------------------------------------

local map = vim.api.nvim_set_keymap
local default_opts = {noremap = true, silent = true}
local cmd = vim.cmd

-----------------------------------------------------------
-- Neovim shortcuts:
-----------------------------------------------------------

map('n', '<leader>mi', ':PackerInstall<CR>', default_opts)
map('n', '<leader>mu', ':PackerUpdate<CR>', default_opts)
map('n', '<leader>mc', ':PackerCompile<CR>', default_opts)
map('n', '<leader>mC', ':PackerClean<CR>', default_opts)

-- map Esc to kk
map('i', 'kk', '<Esc>', {noremap = true})

-- fast saving with <leader> and s
map('n', '<leader>w', ':w<CR>', default_opts)
map('n', '<leader>s', ':luafile $MYVIMRC<CR>', default_opts)
map('n', '<leader>d', ':bd<CR>', default_opts)
map('n', '<leader><leader>', ':bn<CR>', default_opts) -- search file

-- move around splits using Ctrl + {h,j,k,l}
map('n', '<leader>mh', '<C-w>h', default_opts)
map('n', '<leader>mj', '<C-w>j', default_opts)
map('n', '<leader>mk', '<C-w>k', default_opts)
map('n', '<leader>ml', '<C-w>l', default_opts)

map('n', '<C-Tab>', 'gt', default_opts)
map('n', '<C-S-Tab>', 'gT', default_opts)

map('n', '<leader>v', ':vnew<CR>', default_opts)
map('n', '<leader>n', ':new<CR>', default_opts)

map('n', '<leader>tn', ':tabnew<CR>', default_opts)
map('n', '<leader>th', ':-tabmove<CR>', default_opts)
map('n', '<leader>tl', ':+tabmove<CR>', default_opts)

map('n', '<leader>i', ':exec &nu==&rnu? "se nu!" : "se rnu!"<CR>', default_opts)
map('n', '<C-Space>', ':exec &bg=="light"? "set bg=dark" : "set bg=light"<CR>', default_opts)

-----------------------------------------------------------
-- Applications & Plugins shortcuts:
-----------------------------------------------------------

-- open terminal
map('n', '<leader>tt', ':term<CR>', default_opts)

-- nvim-tree
map('n', '<C-n>', ':NvimTreeToggle<CR>', default_opts)       -- open/close

map('n', 'o', 'o <Esc>', default_opts)
map('n', 'O', 'O <Esc>', default_opts)
map('n', '<Leader>h', ':nohlsearch<CR>', default_opts)

map('n', 'Y', 'y$', default_opts)
map('n', '<Leader>y', '"+y', default_opts)
map('v', '<Leader>y', '"+y', default_opts)
map('n', '<Leader>Y', 'gg"+yG', default_opts)
map('n', '<Leader>p', '"+p', default_opts)
map('n', '<Leader>P', '"+P', default_opts)

map('n', '<Leader>ff', ':lua require([[telescope.builtin]]).find_files()<cr>'  , default_opts)
map('n', '<Leader>fg', ':lua require([[telescope.builtin]]).live_grep()<cr>'  , default_opts)
map('n', '<Leader>fb', ':lua require([[telescope.builtin]]).buffers()<cr>'  , default_opts)
map('n', '<Leader>fh', ':lua require([[telescope.builtin]]).help_tags()<cr>'  , default_opts)
map('n', '<Leader>fc', ':lua require([[telescope.builtin]]).colorscheme()<cr>', default_opts)

map('n', '<Leader>/',  ':lua require[[telescope.builtin]].current_buffer_fuzzy_find{}<CR>', default_opts)

map('n', 'f', "<cmd>lua require'hop'.hint_words()<cr>", {})
map('v', 'f', "<cmd>lua require'hop'.hint_words()<cr>", {})
map('o', 'f', "<cmd>lua require'hop'.hint_words()<cr>", {})

map('n', '<leader>j', ':call comfortable_motion#flick(90)<CR>', default_opts)
map('n', '<leader>k', ':call comfortable_motion#flick(-90)<CR>', default_opts)

map('n', '<leader>b', ':!cp ~/boilerplates/boilerplate.%:e %<Enter>', default_opts)