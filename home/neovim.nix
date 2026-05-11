{ config, pkgs, ... }:

{

  # i currently have a normie neovim config in ~/.config/nvim and this module is here to manage the deps, though i do plan to make a nix wrapper soon for my entire neovim config
  environment.systemPackages = with pkgs; [
    neovim
    #lazygit
    #fzf
    #ripgrep
    #fd
    #rustup
    #rust-analyzer
  ];

}
