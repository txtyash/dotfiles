return {
  -- LSP keymaps
  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- disable i_Ctrl-k. Used for digraphs
      keys[#keys + 1] = { "<c-k>", false, mode = "i" }
      -- Default i_Ctrl-h is used for <BS>
      keys[#keys + 1] = { "<C-h>", vim.lsp.buf.signature_help, mode = "i" }
      keys[#keys + 1] = { "<C-s><C-d>", vim.diagnostic.open_float, mode = { "n", "i" } }
      keys[#keys + 1] = { "<C-s>d", vim.diagnostic.open_float, mode = { "n", "i" } }
    end,
  },
}
