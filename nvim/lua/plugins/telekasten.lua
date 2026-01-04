return {
  'renerocksai/telekasten.nvim',
  dependencies = {'nvim-telescope/telescope.nvim'},
  config = function()

    vim.keymap.set("i", "[[", "<cmd>Telekasten insert_link<CR>")

    require('telekasten').setup({
      home = vim.fn.expand("~/notes"),
      dailies = 'daily',
      weeklies = 'weekly',
      monthlies = 'monthly',
      quarterlies = 'quarterly', 
      yearlies = 'yearly',     
      templates = 'templates',    
      template_new_note =  '/home/yash/notes/templates/new.md',    
      template_new_daily = '/home/yash/notes/templates/daily.md',  
      template_new_weekly =  '/home/yash/notes/templates/weekly.md', 
      template_new_monthly = '/home/yash/notes/templates/monthly.md',
      template_new_quarterly = '/home/yash/notes/templates/quarterly.md',
      template_new_yearly = '/home/yash/notes/templates/yearly.md',  

      image_subdir = "images",

      new_note_filename = "uuid",
      uuid_type = "%Y%m%d%H%M%S",

      image_link_style = "markdown",

      command_palette_theme = "dropdown",
      show_tags_theme = "dropdown",
      clipboard_program = "wl-paste",
    })
  end
}
