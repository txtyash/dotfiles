local cmp = require("cmp")

return {
  "hrsh7th/nvim-cmp",
  opts = {
    mapping = {
      ["<Tab>"] = cmp.mapping.select_next_item(),
      ["<S-Tab>"] = cmp.mapping.select_prev_item(),
      ["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace }),
    },
  },
}
