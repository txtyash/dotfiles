return {
  "neovim/nvim-lspconfig",
  config = function()

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
      "gopls"
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

  end,
}
