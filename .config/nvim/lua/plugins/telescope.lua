return {
  "nvim-telescope/telescope.nvim",

  opts = {
    pickers = {
      buffers = {
        show_all_buffers = true,
        sort_lastused = true,
        theme = "dropdown",
        previewer = false,
        mappings = {
          i = {
            ["<c-d>"] = "delete_buffer",
          },
          n = {
            ["dd"] = "delete_buffer",
          },
        },
      },
    },
  },

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
