{ inputs, ...}:
# swag aura neovim config using NvF 
# note that file is NixOS managed, not hm!!!

{
  imports = [ inputs.nvf.nixosModules.default ]; # importing NvF from flake
  

  programs.nvf = {
    enable = true; settings = { vim.globals.mapleader = " ";
      vim.vimAlias = true;
      vim.opts.tabstop = 2;
      vim.options.shiftwidth = 2;
      vim.theme = {
        enable = true;
        transparent = true;
        name = "rose-pine";
        style = "main";
      };
      vim.clipboard = { # change clipboard provider if you are not on wayland.
        enable = true;
        registers = "unnamedplus";
        #providers.wl-copy.enable = true;
        #providers.wl-copy.package = pkgs.wl-clipboard; 
      };

      vim.lsp = {
        enable = true;
        #harper-ls.enable = true;
      };     
      vim.languages = { # all my languages woohoo
        rust.enable = true;
        nix.enable = true;
      };
      vim.treesitter.enable = true;

      # extensible plugins
      vim.telescope.enable = true;

      vim.filetree.neo-tree.enable = true;
      vim.maps.normal."<leader>e" = { # code from notashelf on NvF github :3
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

    };
  };
  

}
