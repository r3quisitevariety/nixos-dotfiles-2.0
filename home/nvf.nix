{ inputs, pkgs, ...}:

# swag aura neovim config using NvF 
# note that file is NixOS managed, not hm!!!

{
  imports = [ inputs.nvf.nixosModules.default ]; # importing NvF from flake
  

  programs.nvf = {
    enable = true;
    settings = {
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
    };


  };
  

}
