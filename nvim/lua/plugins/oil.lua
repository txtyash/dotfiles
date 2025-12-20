-- https://github.com/stevearc/oil.nvim
-- TODO: try https://github.com/A7Lavinraj/fyler.nvim
return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {},
  dependencies = { { "nvim-mini/mini.icons", opts = {} } },
  lazy = false,
  config = function()
    vim.keymap.set("n", "<leader>o", "<cmd>Oil<CR>", { desc = "Open parent directory" })
    require("oil").setup()
  end
}
