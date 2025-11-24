return {
  "neovim/nvim-lspconfig",
  config = function()
    -- BUG: Overriding dprint command causes it to not activate
    -- vim.lsp.config('dprint', {
    --   cmd = { "dprint", "fmt" },
    -- })
    vim.lsp.enable({
      -- note taking
      "tinymist",
      "marksman",
      "dprint",
      -- system
      "lua_ls",
      "zls",
      -- web dev
      "cssls",
      "eslint",
      "html",
      "jsonls",
      "nil_ls",
      "svelte",
      "tailwindcss",
      "ts_ls",
      -- dotnet
      "lemminx",
      -- "csharp_ls",
      "omnisharp",
      "qmlls"
    })
  end,
}
