-- NOTE: avoid lazy loading as the autocmds may not be caught by nvim-rooter.lua.
return {
  'notjedi/nvim-rooter.lua',
  config = function() require 'nvim-rooter'.setup() end
}
