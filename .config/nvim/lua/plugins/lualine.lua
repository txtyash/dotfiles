-- Bubbles config for lualine
-- Author: zim0369
-- MIT license, see LICENSE for more details.

-- stylua: ignore
local colors = {
  blue   = '#80a0ff',
  cyan   = '#79dac8',
  black  = '#000000',
  cream  = '#fffdd0',
  red    = '#ff5189',
  violet = '#d183e8',
  grey   = '#303030',
}

local lilly_pilly_theme = {
  normal = {
    a = { fg = colors.cream, bg = colors.black },
    b = { fg = colors.black, bg = colors.violet, gui = "bold" },
    c = { fg = colors.black, bg = colors.black },
  },

  insert = { b = { bg = colors.blue, fg = colors.black, gui = "bold" } },
  visual = { b = { bg = colors.cyan, fg = colors.black, gui = "bold" } },
  replace = { b = { bg = colors.red, fg = colors.black, gui = "bold" } },

  inactive = {
    a = { fg = colors.cream, bg = colors.black },
    b = { fg = colors.cream, bg = colors.black },
    c = { fg = colors.black, bg = colors.black },
  },
}

return {
  "nvim-lualine/lualine.nvim",
  opts = {
    options = {
      theme = lilly_pilly_theme,
      component_separators = " ",
      section_separators = { left = "", right = "" },
    },
    sections = {
      lualine_a = { "progress" },
      lualine_b = {
        { "mode", separator = { left = "", right = "" }, right_padding = 2, left_padding = 2 },
      },
      lualine_c = { "diagnostics" },
      lualine_x = {},
      lualine_y = {
        { "filetype", separator = { left = "", right = "" }, right_padding = 2, left_padding = 2 },
      },
      lualine_z = { "branch", "selectioncount", "location" },
    },
    inactive_sections = {
      lualine_a = { "filename" },
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = { "progress" },
    },
    tabline = {},
    extensions = {},
  },
}
