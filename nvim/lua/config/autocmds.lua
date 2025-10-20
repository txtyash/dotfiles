-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.hl.on_yank({ timeout = 300 })
  end,
})

-- Enable format on save
local lsp_group = vim.api.nvim_create_augroup("lsp", { clear = true })

-- TODO: :w and :!dprint fmt % act differently for markdown files
-- Auto-format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  group = lsp_group,
  callback = function()
    vim.lsp.buf.format {
      filter = function(client)
        local has_dprint = vim.lsp.get_clients({ name = "dprint", bufnr = 0 })[1]
        return not has_dprint or client.name == "dprint"
      end
    }
  end,
})

-- TODO: Move to another file?
vim.api.nvim_create_user_command('CopyTimestamp', function()
  local timestamp = os.date('%Y%m%d%H%M%S')
  vim.fn.setreg('"', timestamp)
  vim.notify('Copied timestamp to clipboard: ' .. timestamp)
end, {})

-- TODO: Pre highlight for deleting more than one line
