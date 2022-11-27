-- NEOVIDE
vim.o.guifont = "Iosevka Nerd Font:h8"
vim.g.neovide_cursor_vfx_mode = "railgun"

vim.cmd([[ set rnu]])
vim.cmd([[ set spell]])
vim.cmd([[ set nomodeline]]) -- emit startup warning($lvim filename)
vim.opt.clipboard = ""
vim.opt.list = true
vim.opt.tabstop = 2
vim.opt.cmdheight = 0
vim.opt.listchars:append("eol:↴")
vim.opt.listchars:append("space:⋅")
vim.g.glow_binary_path = vim.env.HOME .. "/bin"
-- vim.g.table_mode_corner_corner = '+'
-- vim.g.table_mode_header_fillchar = '='
vim.o.textwidth = 80
vim.opt.shell = '/usr/bin/fish'
lvim.builtin.nvimtree.setup.view.side = "right"
lvim.colorscheme = "gruvbox"

require("lvim.lsp.manager").setup("remark_ls", { autostart = true })

-- LESS INTRUSIVE NOTIFICATIONS
-- BELOW CODE WAS TAKEN FROM @CPea at LunarVim Channel under Chris's server

-- local stages_util = require "notify.stages.util"

-- lvim.builtin.notify.opts.stages = {
--   function(state)
--     local next_height = state.message.height + 2
--     local next_row = stages_util.available_slot(state.open_windows, next_height, stages_util.DIRECTION.BOTTOM_UP)
--     if not next_row then
--       return nil
--     end
--     return {
--       relative = "editor",
--       anchor = "NE",
--       width = state.message.width,
--       height = state.message.height,
--       col = 0,
--       row = next_row,
--       border = "rounded",
--       style = "minimal",
--       opacity = 0,
--     }
--   end,
--   function()
--     return {
--       opacity = { 100 },
--       col = { vim.opt.columns:get() },
--     }
--   end,
--   function()
--     return {
--       col = { vim.opt.columns:get() },
--       time = true,
--     }
--   end,
--   function()
--     return {
--       width = {
--         1,
--         frequency = 2.5,
--         damping = 0.9,
--         complete = function(cur_width)
--           return cur_width < 3
--         end,
--       },
--       opacity = {
--         0,
--         frequency = 2,
--         complete = function(cur_opacity)
--           return cur_opacity <= 4
--         end,
--       },
--       col = { vim.opt.columns:get() },
--     }
--   end,
-- }
