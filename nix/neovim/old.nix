{
  pkgs,
  lib,
  ...
}: {
  programs.neovim = {
    enable = true;
    extraLuaConfig = lib.fileContents ../../.config/nvim/init.lua;
    /*
    plugins = with pkgs.vimPlugins; [
       # nvim-treesitter.withAllGrammars
    	(nvim-treesitter.withPlugins (_: pkgs.tree-sitter.allGrammars))
       kanagawa-nvim
        # LSP Configuration & Plugins
        nvim-lspconfig
        # dependencies = {
          # Automatically install LSPs to stdpath for neovim
          mason-nvim
          mason-lspconfig-nvim
          # Useful status updates for LSP
          fidget-nvim
          # Additional lua configuration, makes nvim stuff amazing!
          neodev-nvim
        # Autocompletion
        nvim-cmp
        # dependencies = {
          # Snippet Engine & its associated nvim-cmp source
          luasnip
          cmp_luasnip
          # Adds LSP completion capabilities
          cmp-nvim-lsp
          # Adds a number of user-friendly snippets
          friendly-snippets
      # Useful plugin to show you pending keybinds-
      which-key-nvim
        # Adds git related signs to the gutter, as well as utilities for managing changes
        gitsigns-nvim
        # Set lualine as statusline
        lualine-nvim
        # See `:help lualine-txt`
        # Add indentation guides even on blank lines
        indent-blankline-nvim
        # Enable `lukas-reineke/indent-blankline-nvim`
      # "gc" to comment visual regions/lines
      comment-nvim
      # Fuzzy Finder (files, lsp, etc)
        telescope-nvim
        # dependencies = {
          plenary-nvim
        # Highlight, edit, and navigate code
        nvim-treesitter
        # dependencies = {
          nvim-treesitter-textobjects
     ];
    */
    defaultEditor = true;
  };
}
