-- TODO: Map alt in tamper monkey to put focs on 'window' TODO When reopening <leader>fg picker. Preserve the previous search query.
return {
  "nvim-telescope/telescope.nvim",
  tag = "0.2.0",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local map = vim.keymap.set
    local telescope = require("telescope")
    local builtin = require("telescope.builtin")
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")
    local function switch_to_picker(picker_name)
        return function(prompt_bufnr)
            -- Get the current text in the prompt
            local current_picker = action_state.get_current_picker(prompt_bufnr)
            local text = current_picker:_get_prompt() 

            -- Close current and open new with the text
            actions.close(prompt_bufnr)
            builtin[picker_name]({ default_text = text })
        end
    end


    telescope.setup({
      defaults = {
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "top",
          }
        },
        sorting_strategy = "ascending",
        mappings = {
          i = {
              ["<C-f>"] = switch_to_picker("find_files"),
              ["<C-g>"] = switch_to_picker("live_grep"),
              ["<C-o>"] = switch_to_picker("oldfiles"),
              ["<C-s>"] = switch_to_picker("builtin"),
              ["<c-b>"] = switch_to_picker("buffers"),
          },
          n = {
              ["<C-f>"] = switch_to_picker("find_files"),
              ["<C-g>"] = switch_to_picker("live_grep"),
              ["<C-o>"] = switch_to_picker("oldfiles"),
              ["<C-s>"] = switch_to_picker("builtin"),
              ["<c-b>"] = switch_to_picker("buffers"),
              ["dd"] = actions.delete_buffer,
          },
        },
      },
      pickers = {
        colorscheme = {
          enable_preview = true,
        },
        buffers = {
          mappings = {
            i = {
              -- ["<c-k>"] = actions.delete_buffer + actions.move_to_top,
            },
            n = {
              -- ["x"] = actions.delete_buffer + actions.move_to_top,
            },
          },
        },
      },
    })
  end,
}
