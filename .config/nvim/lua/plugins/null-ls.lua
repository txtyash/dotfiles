return {
  "jose-elias-alvarez/null-ls.nvim",
  opts = function(_, opts)
    local nls = require("null-ls")
    table.insert(opts.sources, nls.builtins.code_actions.eslint)
    -- table.insert(opts.sources, nls.builtins.diagnostics.eslint) -- slows down nvim
    table.insert(opts.sources, nls.builtins.formatting.prettier)
    -- table.insert(opts.sources, nls.builtins.completion.spell)
  end,
}
