return {
  "tomiis4/Hypersonic.nvim",
  event = "CmdlineEnter",
  cmd = "Hypersonic",
  config = function()
    require("hypersonic").setup({
      -- config
    })
  end,
}
