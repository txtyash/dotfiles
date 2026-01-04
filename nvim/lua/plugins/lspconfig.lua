return {
  "neovim/nvim-lspconfig",
  config = function()
    vim.lsp.enable({
      -- note taking
      "tinymist",
      -- "marksman",
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
      "qmlls"
    })
  end,
}
