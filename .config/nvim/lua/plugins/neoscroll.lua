return {
  -- add symbols-outline
  {
    "karb94/neoscroll.nvim",
    opts = {
      mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "zt", "zz", "zb" },
      performance_mode = true, -- Disable "Performance Mode" on all buffers.
    },
  },
}
