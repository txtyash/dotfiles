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
    local z_utils = require("telescope._extensions.zoxide.utils")
    local function switch_to_picker(picker_name)
        return function(prompt_bufnr)
            -- Get the current text in the prompt
            local current_picker = action_state.get_current_picker(prompt_bufnr)
            local text = current_picker:_get_prompt() 

            -- Close current picker
            actions.close(prompt_bufnr)

            -- Check if it's an extension or a builtin
            if picker_name == "zoxide" then
                telescope.extensions.zoxide.list({ default_text = text })
            else
                builtin[picker_name]({ default_text = text })
            end
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
              ["<C-o>"] = switch_to_picker("oldfiles"),
              ["<C-b>"] = switch_to_picker("buffers"),
              ["<C-z>"] = switch_to_picker("zoxide"),
              ["<C-c>"] = actions.close,
          },
          n = {
              ["<C-f>"] = switch_to_picker("find_files"),
              ["<C-o>"] = switch_to_picker("oldfiles"),
              ["<c-b>"] = switch_to_picker("buffers"),
              ["<C-c>"] = actions.close,
              ["<C-z>"] = switch_to_picker("zoxide"),
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
      extensions = {
        zoxide = {
          prompt_title = "Zoxide",
          mappings = {
            default = {
              after_action = function(selection)
                print("Update to (" .. selection.z_score .. ") " .. selection.path)
              end
            },
            ["<C-x>"] = { action = z_utils.create_basic_command("split") },
            ["<C-s>"] = {
              action = function()
                builtin.builtin()
              end
            },
            ["<C-e>"] = {
              before_action = function(selection) print("before C-s") end,
              action = function(selection)
                vim.cmd.edit(selection.path)
              end
            },
            -- Opens the selected entry in a new split
            ["<C-q>"] = { action = z_utils.create_basic_command("split") },
          },
        }
      }
    })
    telescope.load_extension('zoxide')
  end,
}
