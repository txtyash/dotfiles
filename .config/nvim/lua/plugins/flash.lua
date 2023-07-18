return {
  "folke/flash.nvim",
  event = "VeryLazy",
  ---@type Flash.Config
  opts = {
    modes = {
      search = { enabled = false },
      char = {
        jump_labels = true,
      },
    },
  },
  keys = {},
}
