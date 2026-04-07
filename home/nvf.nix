{ inputs, pkgs, ... }:
# swag aura neovim config using NvF + all programs I use w/ it
# note that file is NixOS managed, not hm!!!

{
  imports = [ inputs.nvf.nixosModules.default ]; # importing NvF from flake

  # nvf specific dependencies (not exhaustive)
  environment.systemPackages = with pkgs; [
    lazygit
  ];

  programs.nvf = {
    enable = true;
    settings = {
      vim.globals.mapleader = " ";
      vim.vimAlias = true;
      vim.opts.tabstop = 2;
      vim.options.shiftwidth = 2;
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
        # change clipboard provider if you are not on wayland.
        enable = true;
        registers = "unnamedplus";
        #providers.wl-copy.enable = true;
        #providers.wl-copy.package = pkgs.wl-clipboard;
      };

      vim.lsp = {
        enable = true;
        #harper-ls.enable = true;
      };
      vim.languages = {
        # all my languages woohoo
        rust.enable = true;
        nix.enable = true;
        # markdown for obsidian :3
        markdown.enable = true;
        markdown.extensions.markview-nvim.enable = false;
      };
      vim.treesitter.enable = true;

      # extensible plugins
      vim.telescope.enable = true;
      # setup opts are needed for plugin to work
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

      vim.git.gitsigns.enable = true; # gitsigns > full git integration suite for sake of minimalism. lazygit + tmux is more unix-like
      vim.binds.whichKey.enable = true;

      #slopsidian
      vim.autocomplete.blink-cmp.enable = true;
      vim.globals.vim_markdown_folding_disable = 1;
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
          action = ''<C-r>=strftime("%A, [[%B %-d, %Y]], %-I:%M%p")<CR><CR>'';
          desc = "Insert date-time stamp";
        }
        {
          key = "<C-S-d>";
          mode = "n";
          action = ''o<C-r>=strftime("%A, [[%B %-d, %Y]], %-I:%M%p")<CR><Esc>'';
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
