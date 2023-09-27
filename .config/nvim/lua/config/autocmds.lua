vim.api.nvim_create_autocmd("FileType", {
  desc = "Close Netrw",
  pattern = "netrw",
  group = vim.api.nvim_create_augroup("netrw_mapping", { clear = true }),
  callback = function()
    vim.keymap.set("n", "<leader>n", "<cmd>bd<cr>", { desc = "Close Netrw", buffer = true })
    vim.keymap.set("n", "<leader>e", require("oil").open, { desc = "close oil", buffer = true })
    vim.keymap.set("n", "g?", "<cmd>h netrw-quickmap<cr>", { desc = "Close Netrw", buffer = true })
    vim.keymap.set("n", "~", "<cmd>Ex ~<cr>", { desc = "Close Netrw", buffer = true })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  desc = "Open Netrw",
  pattern = "oil",
  group = vim.api.nvim_create_augroup("oil_mapping", { clear = true }),
  callback = function()
    vim.keymap.set("n", "<BS><BS>", "<cmd>bd<cr>", { desc = "close oil", buffer = true })
    vim.keymap.set("n", "<leader>e", "<cmd>bd<cr>", { desc = "close oil", buffer = true })
    vim.keymap.set("n", "<leader>n", function()
      local path = require("oil").get_current_dir()
      vim.cmd({ cmd = "Ex", args = { path } })
    end, { desc = "open netrw", buffer = true })
  end,
})
