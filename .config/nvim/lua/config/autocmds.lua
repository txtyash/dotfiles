vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*.tsx", "*.ts", "*.js", "*.jsx", "*.json", "*.yaml", "*.html", "*.css", "*.scss", "*.md" },
  command = "Prettier",
})
