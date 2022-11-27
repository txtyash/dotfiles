-- add your own keymapping
lvim.keys.normal_mode["yit"] = 'yi>'
lvim.keys.normal_mode["yiq"] = 'yi"'
lvim.keys.normal_mode["vit"] = 'vi>'
lvim.keys.normal_mode["viq"] = 'vi"'
lvim.keys.normal_mode["Y"] = 'gg"+yG``'
lvim.keys.visual_mode["-"] = '"+y'
lvim.keys.normal_mode["-"] = '"+y'
lvim.keys.visual_mode["x"] = '"+ygvd' -- TODO: Needed?
lvim.keys.visual_mode["+"] = '"+p'
lvim.keys.normal_mode["+"] = '"+P'
lvim.keys.normal_mode["_"] = "a <esc>"
lvim.keys.normal_mode["o"] = "o <BS><Esc>"
lvim.keys.normal_mode["O"] = "O <BS><Esc>"
lvim.keys.normal_mode["<C-s>"] = ":w<CR>"
lvim.keys.insert_mode["<Del>"] = "<esc>ciw"
lvim.keys.normal_mode["<C-l>"] = ":nohl<CR>"
lvim.keys.normal_mode["<C-w>s"] = ":new<CR>"
lvim.keys.normal_mode["<C-w>v"] = ":vnew<CR>"
lvim.keys.normal_mode["<M-c>"] = ':exec &bg=="light"? "set bg=dark" : "set bg=light"<CR>'
lvim.keys.insert_mode["<M-c>"] = '<esc>:exec &bg=="light"? "set bg=dark" : "set bg=light"<CR>i'
lvim.keys.visual_mode["s"] = "<CMD>lua require'hop'.hint_words()<CR>"
lvim.keys.normal_mode["s"] = "<CMD>lua require'hop'.hint_words()<CR>"
vim.api.nvim_set_keymap("o", "s", "<CMD>lua require'hop'.hint_words()<CR>", {})
lvim.keys.normal_mode["S"] = "<CMD>BufferLinePick<CR>"
-- use ^ as ^ and ^^ as 0
vim.cmd([[nnoremap <expr> ^ match(getline('.'), '\S') == col('.') - 1 ? '0' : '^']])

lvim.keys.normal_mode["<C-b>"] = "<CMD>:bp<CR>"
lvim.keys.normal_mode["<C-f>"] = "<CMD>:bn<CR>"

lvim.builtin.which_key.mappings.n = { ":NeoTreeFocusToggle<CR>", "Open NeoTree" }

-- lvim.builtin.nvimtree.on_config_done = function()
--   lvim.builtin.which_key.mappings.e = {":NeoTreeFocusToggle<CR>", "Open NeoTree"}
-- end

-- lvim.builtin.nvimtree.setup.view.mappings = {
--   custom_only = true,
--   list = {
--     { key = { "l" }, action = "edit" },
--     { key = { "O" }, action = "edit_no_picker" },
--     { key = { "o" }, action = "cd" },
--     { key = "v", action = "vnew" },
--     { key = "s", action = "new" },
--     { key = "t", action = "tabnew" },
--     { key = "b", action = "prev_sibling" },
--     { key = "w", action = "next_sibling" },
--     { key = "P", action = "parent_node" },
--     { key = "h", action = "close_node" },
--     { key = "<Tab>", action = "preview" },
--     { key = "^", action = "first_sibling" },
--     { key = "$", action = "last_sibling" },
--     { key = "I", action = "toggle_dotfiles" },
--     { key = "R", action = "refresh" },
--     { key = "a", action = "create" },
--     { key = "d", action = "remove" },
--     { key = "D", action = "trash" },
--     { key = "r", action = "rename" },
--     { key = "<C-r>", action = "full_rename" },
--     { key = "x", action = "cut" },
--     { key = "c", action = "copy" },
--     { key = "p", action = "paste" },
--     { key = "y", action = "copy_name" },
--     { key = "Y", action = "copy_path" },
--     { key = "gy", action = "copy_absolute_path" },
--     { key = "gp", action = "prev_git_item" },
--     { key = "gn", action = "next_git_item" },
--     { key = "<BS>", action = "dir_up" },
--     { key = "s", action = "system_open" },
--     { key = "q", action = "close" },
--     { key = "g?", action = "toggle_help" },
--   },
-- }

-- TIPS:
-- C-i same as tab
-- C-m same as ret
