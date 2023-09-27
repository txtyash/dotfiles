return {
  "jose-elias-alvarez/null-ls.nvim",
  opts = function(_, opts)
    if type(opts.sources) == "table" then
      local nls = require("null-ls")
      vim.list_extend(opts.sources, {
        nls.builtins.code_actions.eslint,
        nls.builtins.formatting.prettier,
      })
    end
  end,
}
