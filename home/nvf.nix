{ inputs, pkgs, ... }:
# swag aura neovim config using NvF + all programs I use w/ it
# note that file is NixOS managed, not hm!!!

{
  imports = [ inputs.nvf.nixosModules.default ]; # importing NvF from flake

  # nvf specific tooling (not exhaustive)
  environment.systemPackages = with pkgs; [
    lazygit
    cargo
    rustc
  ];

  ###### BASE NVIM STUFF ######
  programs.nvf = {
    enable = true;
    settings = {
      vim.globals.mapleader = " ";
      vim.vimAlias = true;
      vim.opts.tabstop = 2;
      vim.options.shiftwidth = 2;
      vim.options.linebreak = true;
      vim.maps.normal."<leader>w" = {
        # leader + w to toggle line wrapping (wrapping is on by default)
        desc = "Toggle word wrap";
        action = "<cmd>set wrap!<cr>";
      };
      vim.theme = {
        enable = true;
        transparent = true;
        name = "rose-pine";
        style = "main";
      };
      vim.clipboard = {
        enable = true;
        registers = "unnamedplus";
      };

      ###### LANGUAGES, LSP, ETC ######
      vim.lsp = {
        enable = true;
        # harper-ls.enable = true;
        trouble.enable = true;
      };

      vim.languages = {
        rust.enable = true;
        nix.enable = true;
        markdown.enable = true;
      };

      vim.treesitter.enable = true;

      ###### PLUGINS, ADD-ONS ######
      vim.telescope.enable = true;

      vim.formatter.conform-nvim = {
        enable = true;
        setupOpts = {
          format_on_save = {
            lsp_fallback = true;
            timeout_ms = 500;
          };
          formatters_by_ft = {
            rust = [ "rustfmt" ];
            nix = [ "nixfmt" ];
          };
        };
      };

      vim.filetree.neo-tree.enable = true;
      vim.maps.normal."<leader>e" = {
        # code from notashelf on NvF github :3
        desc = "Toggle Neotree";
        action = "<cmd>Neotree toggle reveal<cr>";
      };

      vim.terminal.toggleterm = {
        enable = true;
        setupOpts.direction = "float";
        mappings.open = "<C-space>";
      };

      vim.git.gitsigns.enable = false; # gitsigns > full git integration suite for sake of minimalism. lazygit + tmux is more unix-like
      vim.binds.whichKey.enable = true;

      vim.utility.oil-nvim.enable = true;

      #slopsidian
      vim.globals.vim_markdown_folding_disable = 1; # doesnt work. adressed in extra lua config.
      vim.notes.obsidian = {
        enable = true;
        setupOpts = {
          workspaces = [
            {
              name = "obsidian";
              path = "~/Documents/obsidian";
            }
          ];
          daily_notes = {
            enabled = true;
            folder = "zzz/dailynotes";
            date_format = "%B %-d, %Y";
            default_tags = [ "type/dailynotes" ];
          };
          legacy_commands = false;
          ui.enable = false;
        };
      };

      vim.keymaps = [
        # command palette, ctrl shift d for daily stamp, just like real obsidian
        {
          key = "<C-p>";
          mode = "n";
          action = ":Obsidian<CR>";
          desc = "Obsidian command palette";
        }
        {
          key = "<C-S-d>";
          mode = "i";
          action = ''<C-r>=strftime("###### %A, [[%B %-d, %Y]], %-I:%M%p")<CR><CR>'';
          desc = "Insert date-time stamp";
        }
        {
          key = "<C-S-d>";
          mode = "n";
          action = ''o<C-r>=strftime("###### %A, [[%B %-d, %Y]], %-I:%M%p")<CR><Esc>'';
          desc = "Insert date-time stamp";
        }
        # o leader key for "obsidian"
        {
          key = "<leader>od";
          mode = "n";
          action = ":Obsidian dailies -7 0<CR>";
          desc = "Obsidian dailies (past week)";
        }
        {
          key = "<leader>ot";
          mode = "n";
          action = ":Obsidian tags<CR>";
          desc = "Obsidian tags";
        }
        {
          key = "<leader>on";
          mode = "n";
          action = ":Obsidian new<CR>";
          desc = "Obsidian new note";
        }
        {
          key = "<leader>os";
          mode = "n";
          action = ":Obsidian search<CR>";
          desc = "Obsidian search";
        }
      ];

      vim.maps.normal."<C-w><S-h>" = {
        action = "20<C-w><";
        desc = "Resize split left";
      };
      vim.maps.normal."<C-w><S-l>" = {
        action = "20<C-w>>";
        desc = "Resize split right";
      };
      vim.maps.normal."<C-w><S-k>" = {
        action = "20<C-w>+";
        desc = "Resize split up";
      };
      vim.maps.normal."<C-w><S-j>" = {
        action = "20<C-w>-";
        desc = "Resize split down";
      };

      #blink (currently really minimal)
      #vim.autocomplete.blink-cmp.enable = true;
      #vim.autocomplete.blink-cmp.setupOpts.completion.menu.auto_show = true;
      # misc config
      vim.luaConfigPost = ''
        -- disable stoopid fold from obsidian plugin
        vim.opt.fen = false

        -- blink toggle 
        vim.keymap.set({ "i", "n" }, "<C-q>", function()
          vim.b.completion = not vim.b.completion
          require("blink.cmp").hide()
          vim.notify("Completion " .. (vim.b.completion and "enabled" or "disabled"))
        end, { desc = "Toggle completion" })

        -- Force-disable blink.cmp on every insert entry (overrides startup)
        --vim.api.nvim_create_autocmd("InsertEnter", {
        --  callback = function()
        --    vim.b.completion = false
        --    require("blink.cmp").hide()
        --  end,
        --  group = vim.api.nvim_create_augroup("BlinkDisableStartup", { clear = true })
        --})

        -- Toggle function: flip state, hide/show accordingly
        vim.keymap.set({ "i", "n" }, "<C-q>", function()
          vim.b.completion = not vim.b.completion
          require("blink.cmp")[vim.b.completion and "setup" or "hide"]({})
          vim.notify("Completion " .. (vim.b.completion and "enabled" or "disabled"))
        end, { desc = "Toggle completion" })      


        -- trouble code actions
        require("trouble").setup({
          keys = {
            ["<cr>"] = function(view)
              view:jump()
              vim.schedule(function()
                vim.lsp.buf.code_action({
                  apply = true,
                  filter = function(a) return true end
                })
                vim.schedule(function()
                  require("trouble").focus()
                end)
              end)
            end
          }
        })
      '';

      vim.extraPlugins = {
        smear-cursor = {
          package = pkgs.vimPlugins.smear-cursor-nvim;
          setup = ''
            require("smear_cursor").setup()
          '';
        };
      };
    };
  };

}
