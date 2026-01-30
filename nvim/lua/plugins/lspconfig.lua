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
      "gopls",
      "nil_ls",
      "svelte",
      "tailwindcss",
      "angularls",
      "ts_ls",
      "qmlls"
    })

    -- Enable Harper LSP for only select file types
    local harper_cfg = vim.lsp.config.harper_ls
    harper_cfg.filetypes = { "asciidoc", "gitcommit", "html", "markdown", "toml", "yaml", "typst", "text" }
    vim.lsp.config("harper_ls", harper_cfg)

  end,
}
