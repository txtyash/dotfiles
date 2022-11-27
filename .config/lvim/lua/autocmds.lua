lvim.autocommands = {

  -- Save/Load folds
  { "BufWinLeave",
    {
      pattern = "?*",
      command = "silent! mkview 1"
    },
  },
  { "BufWinEnter",
    {
      pattern = "?*",
      command = "silent! loadview 1"
    },
  },

}
