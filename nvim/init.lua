-- Options
vim.opt.number = true
vim.opt.relativenumber = false -- remove line
vim.opt.relativenumber = true
vim.opt.scrolloff = 0 -- remove line
vim.opt.scrolloff = 3
vim.opt.cursorcolumn = true
vim.opt.cursorline = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wildmenu = true
vim.opt.wildignorecase = true
vim.opt.wildmode = { "full" }
vim.opt.shell = "fish"
vim.g.mapleader = " "
vim.g.netrw_banner = ""
vim.g.netrw_liststyle = 3
vim.cmd("colorscheme oled")

-- Autocmds

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.hl.on_yank({ timeout = 300 })
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
	{ src="https://github.com/coder/claudecode.nvim" },
	{ src="https://github.com/kylechui/nvim-surround" }, 
	{ src="https://github.com/direnv/direnv.vim" }, 
	{ src="https://github.com/MagicDuck/grug-far.nvim" }, 
	{ src="https://github.com/RRethy/vim-illuminate" },
	{ src="https://github.com/lewis6991/gitsigns.nvim" },
	{ src="https://github.com/folke/which-key.nvim" },
	{ src="https://github.com/mofiqul/vscode.nvim" },
	{ src="https://github.com/nvim-treesitter/nvim-treesitter" },
	{
		src="https://github.com/neovim/nvim-lspconfig",
		---@type Flash.Config
		opts = { search = { mode = "fuzzy" } },
	}, 
	{ src="https://github.com/folke/todo-comments.nvim" },
	-- for todo comments
	{ src="https://github.com/nvim-lua/plenary.nvim" },
})

flash = require("flash")
grug = require("grug-far")
surround = require("nvim-surround")
gitsigns = require("gitsigns")
which = require("which-key")
treesitter = require('nvim-treesitter')

grug.setup()
surround.setup()
gitsigns.setup()
treesitter.install { 'go', 'typescript', 'javascript', 'c', 'nix', 'svelte', 'css', 'html', 'json', 'zig', 'lua' }

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "go", "typescript", "javascript", "nix", "svelte", "css", "html", "json", "zig" },
  callback = function() vim.treesitter.start() end,
})

-- KEYMAPS
local map = vim.keymap.set

map({ "n" }, "<leader>?", function() which.show({global = false}) end, { desc = "Buffer Local Keymaps (which-key)" })
map({ "n", "x", "o" }, "s", function() flash.jump() end, { desc = "Flash" })
map({ "n", "x", "o" }, "S", function() flash.treesitter() end, { desc = "Flash Treesitter" })
map({ "o" }, "r", function() flash.remote() end, { desc = "Remote Flash" })
map({ "o", "x" }, "R", function() flash.treesitter_search() end, { desc = "Treesitter Search" })
map({ "c" }, "<c-s>", function() flash.toggle() end, { desc = "Toggle Flash Search" })

-- LSP
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
		vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, opts)
	end,
})

-- Enable Harper LSP for only select file types
local harper_cfg = vim.lsp.config.harper_ls
harper_cfg.filetypes = { "asciidoc", "gitcommit", "html", "markdown", "toml", "yaml", "typst", "text" }
vim.lsp.config("harper_ls", harper_cfg)
