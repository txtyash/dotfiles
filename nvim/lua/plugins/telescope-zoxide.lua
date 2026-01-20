return {
  "jvgrootveld/telescope-zoxide",
	dependencies = {
    'nvim-lua/popup.nvim',
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    require("telescope").load_extension('zoxide')
  end
}
