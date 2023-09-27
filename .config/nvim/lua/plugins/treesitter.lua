return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    -- add tsx and treesitter
    vim.list_extend(opts.ensure_installed, {
      "vim",
      "query",
      "regex",
      "markdown",
      "markdown_inline",
      "kdl",
      -- languages
      "rust",
      "python",
      "nix",
      "java",
      "c",
      "cpp",
      "zig",
      "lua",
      -- web dev
      "typescript",
      "javascript",
      "svelte",
      "astro",
      "vue",
      "sql",
      "tsx",
      "html",
      "css",
      "scss",
      "json",
      "yaml",
      "toml",
      -- shell
      "fish",
      "bash",
    })
  end,
}
