return {
  'nvim-mini/mini.nvim',
  version = false,
  config = function()
    require('mini.files').setup()
    require('mini.notify').setup()
    require('mini.indentscope').setup()
  end
}
