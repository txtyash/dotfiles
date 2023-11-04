{pkgs, ...}:
# let
#   profile = "yash";
#   theme = profile.neovimTheme;
# in
{
  home.shellAliases.v = "nvim";
  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    colorschemes.kanagawa.enable = true;
    # let bindings
    globals = {
      mapleader = " "; # Sets the leader key to space
      maplocalleader = " "; # Sets the leader key to space
      # g:netrw_browsex_viewer= "xdg-open";
    };
    # set bindings
    options = {
      cursorline = true;
      ignorecase = true;
      incsearch = true;
      list = true;
      # TODO: Cleanup listchars
      # listchars = "tab:>,eol:↴,nbsp:↲,trail:-";
      relativenumber = true;
      smartcase = true;
      undofile = true; # Automatically save and restore undo history
      updatetime = 100; # Faster completion
      modeline = true; # Tags such as 'vim:ft=sh'
      modelines = 100; # Sets the type of modelines
      completeopt = ["menu" "menuone" "noselect"];
      scrolloff = 3;
      # tabs
      tabstop = 4;
      shiftwidth = 4;
      softtabstop = 0;
      expandtab = true;
      autoindent = true;
    };
    keymaps = [
      # todo comments
      {
        mode = "n";
        key = "<c-s>t";
        action = ":TodoTelescope<cr>";
      }
      # swtich to previous buffer
      {
        mode = "n";
        key = "_";
        action = ":b#<cr>";
      }
      # delete current buffer
      {
        mode = "n";
        key = "d<cr>";
        action = ":bd<cr>";
      }
      {
        mode = "n";
        key = "xx";
        action = "<c-w>q";
      }
      {
        mode = "n";
        key = "xh";
        action = "<c-w>h";
      }
      {
        mode = "n";
        key = "xl";
        action = "<c-w>l";
      }
      {
        mode = "n";
        key = "xj";
        action = "<c-w>j";
      }
      {
        mode = "n";
        key = "xk";
        action = "<c-w>k";
      }
      {
        mode = "n";
        key = "xs";
        action = ":split<cr>";
      }
      {
        mode = "n";
        key = "xv";
        action = ":vsplit<cr>";
      }
      # better indentation
      {
        mode = "v";
        key = ">";
        action = ">gv";
      }
      {
        mode = "v";
        key = "<";
        action = "<gv";
      }
      {
        mode = "v";
        key = "<TAB>";
        action = ">gv";
      }
      {
        mode = "v";
        key = "<S-TAB>";
        action = "<gv";
      }
      {
        mode = "n";
        key = "<leader>m";
        action = ":MarkdownPreview<cr>";
        options.silent = true;
      }
      # flash
      {
        mode = ["n" "x" "o"];
        key = "s";
        action = ''function() require("flash").jump() end'';
        lua = true;
      }
      {
        mode = ["n" "x" "o"];
        key = "S";
        action = ''
          function()
              require("flash").treesitter()
          end
        '';
        lua = true;
      }
      {
        mode = "o";
        key = "r";
        action = ''
          function()
              require("flash").remote()
          end
        '';
        lua = true;
      }
      {
        mode = ["o" "x"];
        key = "R";
        action = ''
          function()
              require("flash").treesitter_search()
          end
        '';
        lua = true;
      }
      {
        mode = ["c"];
        key = "<c-s>";
        action = ''
          function()
              require("flash").toggle()
          end
        '';
        lua = true;
      }
      {
        mode = "n";
        key = "<leader>s";
        action = ":w<cr>";
      }
      {
        mode = "n";
        key = "j";
        action = "gj";
      }
      {
        mode = "n";
        key = "k";
        action = "gk";
      }
      {
        mode = ["v" "o" "n"];
        key = "H";
        action = "^";
      }
      {
        mode = ["v" "o" "n"];
        key = "L";
        action = "$";
      }
      {
        mode = "n";
        key = "<leader>o";
        action = ":Oil<cr>";
      }
      {
        mode = "n";
        key = "<leader>u";
        action = ":UndotreeToggle<cr>";
      }
      {
        mode = "n";
        key = "+";
        action = "a<space><esc>";
      }
      {
        mode = "n";
        key = "-";
        action = "i<space><esc>";
      }
      {
        mode = "n";
        key = "o";
        action = "o <bs><esc>";
      }
      {
        mode = "n";
        key = "O";
        action = "O <bs><esc>";
      }
      {
        mode = ["i"];
        key = "<c-l>";
        action = "<Right>";
      }
      {
        mode = ["i"];
        key = "<c-h>";
        action = "<Left>";
      }
      {
        mode = "n";
        key = "<leader>w";
        action = ":set wrap!<cr>";
      }
      {
        mode = ["n" "v"];
        key = "<leader>y";
        action = "\"+y";
      }
      {
        mode = ["n" "v"];
        key = "<leader>p";
        action = "\"+p";
      }
      {
        mode = "n";
        key = "<C-h>";
        action = ":SidewaysLeft<cr>";
      }
      {
        mode = "n";
        key = "<C-l>";
        action = ":SidewaysRight<cr>";
      }
      # C-j & C-k moves lines up & down
      {
        mode = "n";
        key = "<C-j>";
        action = ":m .+1<cr>==";
      }
      {
        mode = "n";
        key = "<C-k>";
        action = ":m .-2<cr>==";
      }
      {
        mode = ["i"];
        key = "<C-j>";
        action = "<esc>:m .+1<cr>==gi";
      }
      {
        mode = ["i"];
        key = "<C-k>";
        action = "<esc>:m .-2<cr>==gi";
      }
      {
        mode = ["v"];
        key = "<C-j>";
        action = ":m '>+1<cr>gv=gv";
      }
      {
        mode = ["v"];
        key = "<C-k>";
        action = ":m '<-2<cr>gv=gv";
      }
    ];
    autoCmd = [
      # Vertically center document when entering insert mode
      # {
      #   event = "InsertEnter";
      #   command = "norm zz";
      # }

      # Remove trailing whitespace on save
      {
        event = "BufWrite";
        command = "%s/\\s\\+$//e";
      }

      # Open help in a vertical split
      # {
      #   event = "FileType";
      #   pattern = "help";
      #   command = "wincmd L";
      # }

      # Set indentation to 2 spaces for nix files
      {
        event = "FileType";
        pattern = "nix";
        command = "setlocal tabstop=2 shiftwidth=2";
      }

      # {
      #   event = "FileType";
      #   pattern = "oil";
      #   callback = ''
      #     function()
      #       vim.keymap.set("n", "<leader>o", ":bd<cr>", { desc = "close oil", buffer = true })
      #     end
      #   '';
      # }

      # Enable spellcheck for some filetypes
      {
        event = "FileType";
        pattern = [
          "tex"
          "latex"
          "markdown"
          "norg"
          "text"
        ];
        command = "setlocal spell spelllang=en";
      }
    ];
    plugins = {
      comment-nvim = {
        enable = true;
      };
      trouble = {
        enable = true;
      };
      bufferline = {
        enable = false;
        alwaysShowBufferline = false;
      };
      lsp = {
        enable = true;

        keymaps = {
          silent = true;
          diagnostic = {
            # Navigate in diagnostics
            "[d" = "goto_prev";
            "]d" = "goto_next";
            "<leader>d" = "open_float";
          };

          lspBuf = {
            gd = "definition";
            gD = "references";
            gt = "type_definition";
            gi = "implementation";
            K = "hover";
            "<leader>r" = "rename";
          };
        };

        enabledServers = [
          "bashls"
          "clangd"
          "nil_ls"
          "lua_ls"
          "eslint"
          "html"
          "jsonls"
          "cssls"
          "zls"
        ];
      };
      # NOTE: This plugin handles everything for rust.
      rust-tools = {
        enable = true;
      };
      nvim-cmp = {
        enable = true;

        snippet.expand = "luasnip";

        mapping = {
          "<C-u>" = "cmp.mapping.scroll_docs(-3)";
          "<C-d>" = "cmp.mapping.scroll_docs(3)";
          "<C-Space>" = "cmp.mapping.complete()";
          "<tab>" = "cmp.mapping.close()";
          "<c-n>" = {
            modes = ["i" "s"];
            action = "cmp.mapping.select_next_item()";
          };
          "<c-p>" = {
            modes = ["i" "s"];
            action = "cmp.mapping.select_prev_item()";
          };
          "<CR>" = "cmp.mapping.confirm({ select = true })";
        };

        sources = [
          {name = "path";}
          {name = "nvim_lsp";}
          {name = "cmp_tabnine";}
          {name = "luasnip";}
          {
            name = "buffer";
            # Words from other open buffers can also be suggested.
            option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
          }
          {name = "neorg";}
        ];
      };
      luasnip = {
        enable = true;
      };
      lspkind = {
        enable = true;

        cmp = {
          enable = true;
          menu = {
            nvim_lsp = "[LSP]";
            nvim_lua = "[api]";
            path = "[path]";
            luasnip = "[snip]";
            buffer = "[buf]";
            neorg = "[norg]";
            cmp_tabnine = "[t9]";
          };
        };
      };
      # files & dir navigation
      oil = {
        enable = true;
        deleteToTrash = false; # TODO: Configure trash
        keymaps = {
          "<C-s>" = "false";
          "<C-h>" = "false";
          "xv" = "actions.select_vsplit";
          "xs" = "actions.select_split";
        };
        columns = {
          icon.enable = true;
          permissions.enable = true;
          type.enable = true;
        };
      };
      # buffer navigation
      flash = {
        enable = true; # mapping
      };
      # syntax
      treesitter = {
        enable = true;

        nixvimInjections = true;

        folding = true;
        indent = true;
      };
      markdown-preview = {
        enable = true;

        # theme = "dark";
      };
      treesitter-refactor = {
        enable = true;
        highlightDefinitions.enable = true;
      };
      # code folding
      nvim-ufo = {
        enable = true;
      };
      gitsigns = {
        enable = true;
      };
      nvim-autopairs.enable = true;
      nvim-colorizer = {
        enable = true;
        userDefaultOptions.names = false;
      };
      # highlight all occurences of of WUTC(word under the cursor)
      illuminate = {
        enable = true;
      };
      # keymap previewer helper
      which-key = {
        enable = true;
      };
      /*
         Easy to spot marker comments
      hack: wEiRd CoDe
      warn: A warning
      perf: Fully optimized(Performant)
      note: A note
      test: A test
      fix: Needs fixing
      */
      todo-comments = {
        enable = true;
      };
      conform-nvim = {
        enable = true;
        formattersByFt = {
          javascript = ["prettier"];
          nix = ["nix fmt"];
          rust = ["rustfmt"];
        };
      };
      # Tim Pope's surround plugin
      surround = {
        enable = true;
      };
      # Fuzzy navigation menu for files, buffers & more
      telescope = {
        enable = true;
        keymaps = {
          # Find files using Telescope command-line sugar.
          "<c-s>f" = "find_files";
          "<c-s>g" = "live_grep";
          "<c-s>b" = "current_buffer_fuzzy_find";
          "<c-s>m" = "marks";
          "<c-s>h" = "help_tags";
          "<c-s>d" = "diagnostics";
          "<c-s>D" = "lsp_definitions";
          "<c-s>o" = "oldfiles";
          "<c-s>c" = "commands";
          "<c-s>C" = "command_history";
          "<c-s>q" = "quickfix";
          "<c-s>r" = "registers";
          "<c-s>v" = "vim_options";
          "<c-s>x" = "spell_suggest";
          "<c-s>lr" = "lsp_references";
          "<c-s>ls" = "lsp_document_symbols";
          "<c-s>ld" = "diagnostics";
          "<c-s>lD" = "lsp_definitions";
          "<c-s>lt" = "lsp_type_definitions";
          "<leader><space>" = "buffers";
          # TODO: FZF like bindings
          # "<C-p>" = "git_files";
          # "<leader>p" = "oldfiles";
          # "<C-f>" = "live_grep";
        };
        extraOptions.pickers.buffers = {
          show_all_buffers = "true";
          theme = "dropdown";
          mappings = {
            i = {
              "<c-s>" = "delete_buffer";
            };
            n = {
              "dd" = "delete_buffer";
              "x" = "delete_buffer";
            };
          };
        };
        keymapsSilent = true;
        defaults = {
          file_ignore_patterns = [
            "^.git/"
            "^.mypy_cache/"
            "^__pycache__/"
            "^output/"
            "^data/"
            "%.ipynb"
          ];
          set_env.COLORTERM = "truecolor";
        };
      };

      # Faster file navigation
      harpoon = {
        enable = false; # TODO: Configure later
        enableTelescope = true;
      };
      # Navigate your vim undo history
      undotree = {
        enable = false;
      };
      # Indentation guides
      indent-blankline = {
        # TODO: Autostart
        enable = true;
      };
      nix = {
        enable = true;
      };
      nix-develop = {
        enable = true;
      };
      # Discord rich presence
      presence-nvim = {
        # TODO: Configure later
        enable = false;
        neovimImageText = "I'm still breathing! Are you?";
        clientId = "1125469005931630675";
        logLevel = "debug";
      };
    };
    # NOTE: Plugins unavailable in nixvim
    extraPlugins = with pkgs.vimPlugins; [
      neoscroll-nvim # FIX: Doesn't work
      sideways-vim
      vim-cool
      # lsp-zero-nvim
      # nvim-lspconfig
      # WARN: Plugins unavailable in nixpkgs:
      # winresizer https://github.com/simeji/winresizer
      # yanky-nvim https://github.com/gbprod/yanky.nvim
      # icon-picker-nvim https://github.com/ziontee113/icon-picker.nvim
      # conform-nvim https://github.com/stevearc/conform.nvim
    ];
  };
  # NOTE. Installing extra packages globally
  home.packages = with pkgs; [
    lua-language-server
    vscode-langservers-extracted
    nil
    zls
    rust-analyzer
  ];
}
/*
map({ "n" }, "<Leader>I", ":IconPickerYank<cr>", { desc = "Icon Yanker" })
map({ "n" }, "<Leader>i", ":IconPickerNormal<cr>", { desc = "Icon Picker" })
map({ "n", "i" }, "<M-c>", theme, { desc = "Toggle theme", silent = true })

map("n", "<leader>e", require("oil").open, { desc = "open oil" })
map("n", "<leader>n", ":Ex<cr>", { desc = "open netrw" })

-- ^ once = ^ & ^ once again = 0
vim.cmd([[nnoremap <expr> ^ match(getline('.'), '\S') == col('.') - 1 ? '0' : '^']])
*/

