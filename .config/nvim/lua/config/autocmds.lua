vim.api.nvim_create_autocmd("FileType", {
  desc = "Close Netrw",
  pattern = "netrw",
  group = vim.api.nvim_create_augroup("netrw_mapping", { clear = true }),
  callback = function()
    vim.keymap.set("n", "<leader>e", "<cmd>Rex<cr>", { desc = "Close Netrw", buffer = true })
  end,
})
