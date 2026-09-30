-- Options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 3
vim.opt.cursorcolumn = true
vim.opt.cursorline = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wildignorecase = true

if vim.fn.executable("nu") == 1 then
  vim.opt.shell = "nu"
  vim.opt.shellcmdflag = "-c"
  vim.opt.shellredir = "out+err> %s"
  vim.opt.shellpipe = "out+err> %s"
  vim.opt.shellquote = ""
  vim.opt.shellxquote = ""
elseif vim.fn.executable("fish") == 1 then
  vim.opt.shell = "fish"
end
vim.g.mapleader = " "
 
-- Autocmds
 
-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.hl.on_yank({ timeout = 300 })
  end,
})
 
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "text", "gitcommit", "typst", "asciidoc", "tex", "plaintex", "rst", "mail", "org" },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "en_us"
    vim.opt_local.spelloptions = "camel"
  end,
})
 
-- Enable format on save
local lsp_group = vim.api.nvim_create_augroup("lsp", { clear = true })
 
-- TODO: :w and :!dprint fmt % act differently for markdown files
-- Auto-format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  group = lsp_group,
  callback = function()
    vim.lsp.buf.format {
      filter = function(client)
        local has_dprint = vim.lsp.get_clients({ name = "dprint", bufnr = 0 })[1]
        return not has_dprint or client.name == "dprint"
      end
    }
  end,
})
 
vim.api.nvim_create_user_command('CopyTimestamp', function()
  local timestamp = os.date('%Y%m%d%H%M%S')
  vim.fn.setreg('"', timestamp)
  vim.notify('Copied timestamp to clipboard: ' .. timestamp)
end, {})
 
-- TODO: Pre highlight for deleting more than one line
vim.pack.add({
	{ src="https://github.com/folke/flash.nvim" },
	{ src="https://github.com/kylechui/nvim-surround" }, 
	{ src="https://github.com/direnv/direnv.vim" }, 
	{ src="https://github.com/MagicDuck/grug-far.nvim" }, 
	{ src="https://github.com/RRethy/vim-illuminate" },
	{ src="https://github.com/lewis6991/gitsigns.nvim" },
	{ src="https://github.com/kdheepak/lazygit.nvim" },
	{ src="https://github.com/folke/which-key.nvim" },
	{ src="https://github.com/nvim-treesitter/nvim-treesitter" },
	{
		src="https://github.com/neovim/nvim-lspconfig",
		---@type Flash.Config
		opts = { search = { mode = "fuzzy" } },
	}, 
	{ src="https://github.com/Saghen/blink.cmp", version=vim.version.range("1.*") },
	{ src="https://github.com/folke/todo-comments.nvim" },
	-- dependency for todo-comments and telescope
	{ src="https://github.com/nvim-lua/plenary.nvim" },
	{ src="https://github.com/nvim-telescope/telescope.nvim" },
	{ src="https://github.com/jvgrootveld/telescope-zoxide" },
	{ src="https://github.com/nvim-tree/nvim-web-devicons" },
	{ src="https://github.com/stevearc/oil.nvim" },
	{ src="https://github.com/selimacerbas/live-server.nvim" },
	{ src="https://github.com/selimacerbas/markdown-preview.nvim" },
	{ src="https://github.com/OXY2DEV/markview.nvim" },
	-- Colorschemes
	{ src="https://github.com/sainnhe/edge" },
	{ src="https://github.com/yorik1984/newpaper.nvim" },
	{ src="https://github.com/rose-pine/neovim", name="rose-pine" },
	{ src="https://github.com/projekt0n/github-nvim-theme" },
	{ src="https://github.com/navarasu/onedark.nvim" },
	{ src="https://github.com/rakr/vim-one" },
	{ src="https://github.com/scottmckendry/cyberdream.nvim" },
	{ src="https://github.com/rebelot/kanagawa.nvim" },
	{ src="https://github.com/ellisonleao/gruvbox.nvim" },
	{ src="https://github.com/folke/tokyonight.nvim" },
	{ src="https://github.com/catppuccin/nvim", name="catppuccin" },
	{ src="https://github.com/Mofiqul/vscode.nvim" },
	{ src="https://github.com/oskarnurm/koda.nvim" },
})
 
vim.cmd("colorscheme koda")
 
flash = require("flash")
grug = require("grug-far")
surround = require("nvim-surround")
gitsigns = require("gitsigns")
which = require("which-key")
treesitter = require('nvim-treesitter')
telescope = require("telescope")
markdown_preview = require("markdown_preview")
todo_comments = require("todo-comments")
markview = require("markview")
blink = require("blink.cmp")
oil = require("oil")
 
grug.setup()
surround.setup()
gitsigns.setup()
telescope.setup()
telescope.load_extension("zoxide")
markdown_preview.setup()
todo_comments.setup()
markview.setup()
oil.setup()
-- Lua matcher, not the default Rust one: its prebuilt binary is unsigned and this machine refuses to load it.
blink.setup({ fuzzy = { implementation = "lua" } })
local langs = { 'go', 'typescript', 'javascript', 'c', 'nix', 'svelte', 'css', 'html', 'json', 'zig', 'lua', 'markdown', 'markdown_inline', 'typst', 'yaml' }
treesitter.install(langs)

vim.api.nvim_create_autocmd("FileType", {
  pattern = langs,
  callback = function() vim.treesitter.start() end,
})
 
-- KEYMAPS
local map = vim.keymap.set
 
map({ "n" }, "<leader>?", function() which.show({global = false}) end, { desc = "Buffer Local Keymaps (which-key)" })
 
-- Save. Goes through :write, so the BufWritePre format-on-save autocmd runs.
map({ "n" }, "<leader>w", "<cmd>write<cr>", { desc = "Save File" })
 
-- Close the current buffer. :bdelete keeps the window and falls back to the
-- alternate buffer, so this trims the buffer list without collapsing a split.
-- It refuses on unsaved changes -- <leader>bD forces and discards them.
map({ "n" }, "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete Buffer" })
map({ "n" }, "<leader>bD", "<cmd>bdelete!<cr>", { desc = "Delete Buffer (force)" })
 
map({ "n" }, "<leader>e", function()
  if vim.bo.filetype == "oil" then oil.close() else oil.open() end
end, { desc = "Oil: Toggle at file's dir" })
 
map({ "n", "x", "o" }, "s", function() flash.jump() end, { desc = "Flash" })
map({ "n", "x", "o" }, "S", function() flash.treesitter() end, { desc = "Flash Treesitter" })
map({ "o" }, "r", function() flash.remote() end, { desc = "Remote Flash" })
map({ "o", "x" }, "R", function() flash.treesitter_search() end, { desc = "Treesitter Search" })
map({ "c" }, "<c-s>", function() flash.toggle() end, { desc = "Toggle Flash Search" })
 
-- Telescope. Leader is <space> (set above), so these are space-f-<key>.
-- live_grep shells out to ripgrep, find_files to fd -- both from systemPackages.
local builtin = require("telescope.builtin")
map({ "n" }, "<leader>ff", builtin.find_files, { desc = "Telescope: Find Files" })
map({ "n" }, "<leader>fg", builtin.live_grep, { desc = "Telescope: Live Grep" })
map({ "n" }, "<leader>fb", builtin.buffers, { desc = "Telescope: Buffers" })
map({ "n" }, "<leader>fh", builtin.help_tags, { desc = "Telescope: Help Tags" })
map({ "n" }, "<leader>fd", builtin.diagnostics, { desc = "Telescope: Diagnostics" })
map({ "n" }, "<leader>fr", builtin.resume, { desc = "Telescope: Resume Last Picker" })
map({ "n" }, "<leader>fc", function() builtin.colorscheme({ enable_preview = true }) end, { desc = "Telescope: Colorschemes (preview)" })
map({ "n" }, "<leader>fo", builtin.oldfiles, { desc = "Telescope: Recent Files" })
map({ "n" }, "<leader>f/", builtin.current_buffer_fuzzy_find, { desc = "Telescope: Find in Buffer" })
map({ "n" }, "<leader>fs", builtin.lsp_document_symbols, { desc = "Telescope: Document Symbols" })
map({ "n" }, "<leader>fw", builtin.grep_string, { desc = "Telescope: Grep Word Under Cursor" })
map({ "n" }, "<leader>gs", builtin.git_status, { desc = "Telescope: Git Status" })
map({ "n" }, "<leader>gg", "<cmd>LazyGit<cr>", { desc = "LazyGit" })
map({ "n" }, "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Telescope: TODO Comments" })
map({ "n" }, "<leader>fk", builtin.keymaps, { desc = "Telescope: Keymaps" })
map({ "n" }, "<leader>fx", builtin.commands, { desc = "Telescope: Commands" })
map({ "n" }, "<leader>fH", builtin.search_history, { desc = "Telescope: Search History" })
map({ "n" }, "<leader>fm", builtin.marks, { desc = "Telescope: Marks" })
map({ "n" }, "<leader>fj", builtin.jumplist, { desc = "Telescope: Jumplist" })
map({ "n" }, "<leader>fq", builtin.quickfix, { desc = "Telescope: Quickfix" })
map({ "n" }, "<leader>fR", builtin.registers, { desc = "Telescope: Registers" })
map({ "n" }, "<leader>fT", builtin.treesitter, { desc = "Telescope: Treesitter Symbols" })
map({ "n" }, "<leader>fS", builtin.spell_suggest, { desc = "Telescope: Spell Suggest" })
 
-- LSP
vim.lsp.config("*", { capabilities = blink.get_lsp_capabilities(nil, true) })
 
vim.lsp.enable({
	-- note taking
	"tinymist",
	"marksman",
	-- system
	"lua_ls",
	"zls",
	-- web dev
	"cssls",
	"eslint",
	"harper_ls",
	"html",
	"jsonls",
	"nil_ls",
	"svelte",
	"tailwindcss",
	"angularls",
	"ts_ls",
	"qmlls",
	-- Go Backend
	"docker_language_server",
	"gopls",
	-- C/C++
	"clangd"
})
 
-- LSP keymaps
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local opts = { buffer = ev.buf }
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
 
		-- Harper reports spelling itself, so drop Neovim's overlapping highlights.
		if vim.lsp.get_client_by_id(ev.data.client_id).name == "harper_ls" then
			vim.opt_local.spell = false
		end
	end,
})
 
-- Enable Harper LSP for only select file types
local harper_cfg = vim.lsp.config.harper_ls
harper_cfg.filetypes = { "asciidoc", "gitcommit", "html", "markdown", "toml", "yaml", "typst", "text" }
vim.lsp.config("harper_ls", harper_cfg)

local tailwind_cfg = vim.lsp.config.tailwindcss
tailwind_cfg.filetypes = vim.tbl_filter(function(ft) return ft ~= "markdown" end, tailwind_cfg.filetypes)
vim.lsp.config("tailwindcss", tailwind_cfg)
 
-- ZOXIDE
local function zoxide(args)
  local res = vim.system(vim.list_extend({ "zoxide" }, args), { text = true }):wait()
  if res.code ~= 0 then
    return nil, vim.trim((res.stderr or "") .. (res.stdout or ""))
  end
  return vim.trim(res.stdout)
end
 
local function z_list(...)
  local out = zoxide(vim.list_extend({ "query", "-l", "--" }, { ... }))
  return out and vim.split(out, "\r?\n", { trimempty = true }) or {}
end
 
local function z_jump(cmd, args)
  local dir, err = zoxide(vim.list_extend({ "query", "--" }, args))
  if not dir then
    return vim.notify(err ~= "" and err or "zoxide: no match", vim.log.levels.WARN)
  end
  vim.cmd(cmd .. " " .. vim.fn.fnameescape(dir))
  vim.notify(cmd .. " " .. dir)
end
 
for name, cmd in pairs({ Z = "cd", Zl = "lcd", Zt = "tcd" }) do
  vim.api.nvim_create_user_command(name, function(o) z_jump(cmd, o.fargs) end, {
    nargs = "*",
    desc = "zoxide " .. cmd,
    complete = function(lead)
      return vim.tbl_map(vim.fn.fnameescape, z_list(lead))
    end,
  })
end
 
map({ "n" }, "<leader>fz", telescope.extensions.zoxide.list, { desc = "Telescope: Zoxide" })
 
vim.api.nvim_create_autocmd("DirChanged", {
  callback = function(ev)
    if ev.file and ev.file ~= "" then vim.system({ "zoxide", "add", ev.file }) end
  end,
})
