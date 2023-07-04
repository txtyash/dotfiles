return {
  "nvim-telescope/telescope.nvim",
  keys = {
    {
      "<leader><space>",
      function()
        require("telescope.builtin").buffers()
      end,
      desc = "Switch buffers",
    },
  },
}
