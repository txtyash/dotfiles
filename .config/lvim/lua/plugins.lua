-- Additional Plugins
lvim.plugins = {

  -- COLORSCHEMES
  { 'savq/melange' },
  { 'Mofiqul/vscode.nvim' },
  { "ellisonleao/gruvbox.nvim" },
  { 'bluz71/vim-moonfly-colors' },
  { 'projekt0n/github-nvim-theme' },
  { 'rockerBOO/boo-colorscheme-nvim' },

  -- PLugins
  { "mattn/webapi-vim" },
  { 'tpope/vim-repeat' },
  { 'simeji/winresizer' },
  { 'tpope/vim-surround' },
  { 'svban/YankAssassin.vim' },
  { 'dhruvasagar/vim-table-mode' },
  { 'davidgranstrom/nvim-markdown-preview' },
  { 'krivahtoo/silicon.nvim', run = './install.sh' },

  { 'sbdchd/neoformat' },

  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("plugins.neotree").config()
    end,
  },

  { 'petertriho/nvim-scrollbar',
    config = function()
      require("plugins.scrollbar").config()
    end,
  },

  { 'norcalli/nvim-colorizer.lua',
    config = function()
      require("plugins.colorizer").config()
    end,
  },

  { 'karb94/neoscroll.nvim',
    config = function()
      require("plugins.neoscroll").config()
    end,
  },

  { 'phaazon/hop.nvim',
    branch = 'v1', -- optional but strongly recommended
    config = function()
      require("plugins.hop").config()
    end,
  },

  { 'abecodes/tabout.nvim',
    config = function()
      require("plugins.tabout").config()
    end,
    wants = { 'nvim-treesitter' }, -- or require if not used so far
    after = { 'nvim-cmp' } -- if a completion plugin is using tabs load it before
  },

  { 'lukas-reineke/headlines.nvim',
    config = function()
      require("plugins.headlines").config()
    end,
  },


  --TODO

  -- { 'chentoast/marks.nvim',
  --   config = function()
  --     require("plugins.marks").config()
  --   end,
  -- },

  -- { 'sunjon/shade.nvim' },
  -- { 'lewis6991/spellsitter.nvim' },

}

-- {
--   "folke/trouble.nvim",
--   cmd = "TroubleToggle",
-- },
